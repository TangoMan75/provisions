#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
#
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zenmap
## nmap network scanner graphic interface
##
## @link     https://nmap.org/zenmap/
## @link     https://github.com/nmap/nmap
## @category network
##
## Note: the target field expects nmap subnet syntax, i.e. CIDR notation
## such as 192.168.1.0/24 (or an explicit netmask like 192.168.1.0/255.255.255.0).

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zenmap
DESKTOP="zenmap.desktop"
ICON="zenmap.png"
PIXMAP="zenmapCore/data/pixmaps/${ICON}"

ROOT_DESKTOP="zenmap-root.desktop"
ROOT_LAUNCHER="zenmap-root"

# nmap.org is the canonical download location, the GitHub mirror has no
# release asset for the latest nmap version.
DEFAULT_VERSION=7.993

#--------------------------------------------------

REQUIRED_COMMANDS=(dpkg pipx python3 tar)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl or wget, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${DEFAULT_VERSION}"

#--------------------------------------------------

# zenmap is a GTK 3 frontend written in Python, it relies on the system
# PyGObject bindings instead of building them inside the pipx virtualenv.
SYSTEM_PACKAGES=(nmap python3-gi python3-gi-cairo gir1.2-gtk-3.0)

# ndiff is the companion tool used by zenmap to compare scan results, it
# ships as a separate package on Debian/Ubuntu.
if [ ! -x /usr/bin/ndiff ]; then
    if apt-cache show ndiff &> /dev/null; then
        SYSTEM_PACKAGES+=(ndiff)
    else
        _echo_warning 'ndiff is not available, scan comparison will be disabled\n'
    fi
fi
MISSING_PACKAGES=()
for pkg in "${SYSTEM_PACKAGES[@]}"; do
    if ! dpkg -s "${pkg}" &> /dev/null 2>&1; then
        MISSING_PACKAGES+=("${pkg}")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    _echo_warning "Installing missing system dependencies: ${MISSING_PACKAGES[*]}\n"
    _echo_info "sudo apt-get update && sudo apt-get install -y ${MISSING_PACKAGES[*]}\n"

    if ! sudo apt-get update || ! sudo apt-get install -y "${MISSING_PACKAGES[@]}"; then
        _echo_danger "error: Unable to install system dependencies.\n"
        exit 1
    fi
fi

#--------------------------------------------------

VERSION="${DEFAULT_VERSION}"
SOURCE_DIR="nmap-${VERSION}"
ARCHIVE="${SOURCE_DIR}.tar.bz2"
URL="https://nmap.org/dist/${ARCHIVE}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${ARCHIVE}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${ARCHIVE}"

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${ARCHIVE}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${ARCHIVE}"
fi

#--------------------------------------------------

if [ ! -s "${TEMP_DIR}/${ARCHIVE}" ] || head -n 1 "${TEMP_DIR}/${ARCHIVE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found.\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "tar -xjf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\" \"${SOURCE_DIR}/zenmap\"\n"
tar -xjf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}" "${SOURCE_DIR}/zenmap"

#--------------------------------------------------

ZENMAP_DIR="${TEMP_DIR}/${SOURCE_DIR}/zenmap"

if [ ! -d "${ZENMAP_DIR}" ]; then
    _echo_danger "error: ${APP_NAME} directory not found in archive\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Install ${APP_NAME} with pipx\n"

# --system-site-packages makes the system PyGObject bindings available to the
# virtualenv, so PyGObject is not rebuilt from source.
_echo_info "pipx install --force --system-site-packages \"${ZENMAP_DIR}\"\n"

if ! pipx install --force --system-site-packages "${ZENMAP_DIR}"; then
    _echo_danger "error: Unable to install ${APP_NAME} with pipx.\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Creating symlink to make ${APP_NAME} available system-wide\n"

PIPX_BIN_DIR=$(pipx environment --value PIPX_BIN_DIR 2> /dev/null)
if [ -z "${PIPX_BIN_DIR}" ]; then
    PIPX_BIN_DIR="${HOME}/.local/bin"
fi

if [ ! -x "${PIPX_BIN_DIR}/${APP_NAME}" ]; then
    _echo_danger "error: ${APP_NAME} executable not found in \"${PIPX_BIN_DIR}\"\n"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

_echo_info "sudo ln -sf \"${PIPX_BIN_DIR}/${APP_NAME}\" \"/usr/bin/${APP_NAME}\"\n"
sudo ln -sf "${PIPX_BIN_DIR}/${APP_NAME}" "/usr/bin/${APP_NAME}"

# The zenmap wheel declares a broken ndiff entry point (the module lives in
# the sibling ndiff project), drop its symlink when the system ndiff is used.
if [ -x /usr/bin/ndiff ] && [ -L "${PIPX_BIN_DIR}/ndiff" ]; then
    NDIFF_TARGET=$(readlink -f "${PIPX_BIN_DIR}/ndiff")
    case "${NDIFF_TARGET}" in
        *"/venvs/${APP_NAME}/"*)
            _echo_info "rm -f \"${PIPX_BIN_DIR}/ndiff\"\n"
            rm -f "${PIPX_BIN_DIR}/ndiff"
            ;;
    esac
fi

#--------------------------------------------------

_echo_warning 'Install desktop entry and icon\n'

_echo_info "sudo install -Dm644 \"${ZENMAP_DIR}/install_scripts/unix/${DESKTOP}\" \"/usr/share/applications/${DESKTOP}\"\n"
sudo install -Dm644 "${ZENMAP_DIR}/install_scripts/unix/${DESKTOP}" "/usr/share/applications/${DESKTOP}"

_echo_info "sudo install -Dm644 \"${ZENMAP_DIR}/${PIXMAP}\" \"/usr/share/icons/hicolor/256x256/apps/${ICON}\"\n"
sudo install -Dm644 "${ZENMAP_DIR}/${PIXMAP}" "/usr/share/icons/hicolor/256x256/apps/${ICON}"

# Refresh desktop and icon caches when the matching tools are available
sudo gtk-update-icon-cache -f -t /usr/share/icons/hicolor &> /dev/null || true
sudo update-desktop-database /usr/share/applications &> /dev/null || true

#--------------------------------------------------

# root launcher
#
# pkexec drops the graphical session environment variables, so the wrapper
# restores DISPLAY/XAUTHORITY and forces GTK to use X11/XWayland.
if command -v pkexec &> /dev/null; then
    _echo_warning "Install \"Zenmap (as root)\" launcher and desktop entry\n"

    cat > "${TEMP_DIR}/${ROOT_LAUNCHER}" <<'EOF'
#!/bin/sh

# Run zenmap as root through polkit while keeping access to the current
# graphical session.
XAUTHORITY="${XAUTHORITY:-${HOME}/.Xauthority}"

exec pkexec env \
    DISPLAY="${DISPLAY}" \
    XAUTHORITY="${XAUTHORITY}" \
    GDK_BACKEND=x11 \
    /usr/bin/zenmap "$@"
EOF

    _echo_info "sudo install -Dm755 \"${TEMP_DIR}/${ROOT_LAUNCHER}\" \"/usr/local/bin/${ROOT_LAUNCHER}\"\n"
    sudo install -Dm755 "${TEMP_DIR}/${ROOT_LAUNCHER}" "/usr/local/bin/${ROOT_LAUNCHER}"

    cat > "${TEMP_DIR}/${ROOT_DESKTOP}" <<'EOF'
[Desktop Entry]
Name=Zenmap (as root)
GenericName=GUI Port Scanner
TryExec=zenmap-root
Exec=zenmap-root %F
Terminal=false
Icon=zenmap
Type=Application
Categories=Network;Security;
Comment=A cross-platform GUI for the Nmap Security Scanner.
Keywords=network;scan;scanner;IP;security;
EOF

    _echo_info "sudo install -Dm644 \"${TEMP_DIR}/${ROOT_DESKTOP}\" \"/usr/share/applications/${ROOT_DESKTOP}\"\n"
    sudo install -Dm644 "${TEMP_DIR}/${ROOT_DESKTOP}" "/usr/share/applications/${ROOT_DESKTOP}"
else
    _echo_warning 'pkexec not found, skipping "Zenmap (as root)" shortcut\n'
fi

#--------------------------------------------------

if command -v xdg-user-dir &> /dev/null; then
    DESKTOP_DIR=$(xdg-user-dir DESKTOP)
    if [ -d "${DESKTOP_DIR}" ]; then
        _echo_warning 'Create shortcuts on desktop\n'

        for shortcut in "${DESKTOP}" "${ROOT_DESKTOP}"; do
            if [ -f "/usr/share/applications/${shortcut}" ]; then
                _echo_info "cp -p \"/usr/share/applications/${shortcut}\" \"${DESKTOP_DIR}\"\n"
                cp -p "/usr/share/applications/${shortcut}" "${DESKTOP_DIR}"
            fi
        done
    fi
fi

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

if command -v "${APP_NAME}" &> /dev/null; then
    _echo_success "${APP_NAME} installed successfully\n"
else
    _echo_warning "${APP_NAME} command not found, you may need to restart your shell\n"
fi
