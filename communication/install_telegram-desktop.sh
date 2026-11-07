#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## telegram-desktop
##
## Fast and secure desktop messaging app, perfectly synced with your
## mobile phone. Send messages, photos, videos and files to your
## contacts and groups from your computer.
##
## ```
## # launch from terminal
## telegram-desktop
## ```
##
## @category communication
## @link     https://desktop.telegram.org
## @link     https://github.com/telegramdesktop/tdesktop

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/git/get_latest_release.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(curl tar)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=telegram-desktop
AUTHOR=telegramdesktop
REPOSITORY="${AUTHOR}/tdesktop"
BINARY=Telegram
DESTINATION="${HOME}/.local/share/${APP_NAME}"
BIN_DIR="${HOME}/.local/bin"
APPLICATIONS_DIR="${HOME}/.local/share/applications"
ICON="${DESTINATION}/${APP_NAME}.png"
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

DEFAULT_VERSION=7.3.3

#--------------------------------------------------

VERSION=$(get_latest_release "${REPOSITORY}")
if [ -z "${VERSION}" ]; then
    _echo_warning "Could not resolve latest release, falling back to v${DEFAULT_VERSION}\n"
    VERSION="${DEFAULT_VERSION}"
fi

#--------------------------------------------------

# Telegram Desktop only publishes a Linux x64 tarball
ARCH=$(uname -m)
case "${ARCH}" in
    x86_64|amd64)
        ARCH=x64
        ;;
    *)
        _echo_danger "error: no official Telegram Desktop build for \"${ARCH}\", try: 'https://desktop.telegram.org'\n"
        exit 1
        ;;
esac

REMOTE_FILE="td-setup-linux-${ARCH}-${VERSION}.tar.xz"
ARCHIVE="${REMOTE_FILE}"
URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"
ICON_URL="https://raw.githubusercontent.com/${REPOSITORY}/dev/Telegram/Resources/art/logo_256.png"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME} v${VERSION}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

_echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${REMOTE_FILE}\"\n"
curl -Lf "${URL}" -o "${TEMP_DIR}/${REMOTE_FILE}"

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${REMOTE_FILE}" ] || head -n 1 "${TEMP_DIR}/${REMOTE_FILE}" | grep -q "<!DOCTYPE html>"; then
    _echo_danger "error: Downloaded file is invalid or not found, check: \"${URL}\"\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Extract \"${ARCHIVE}\"\n"

_echo_info "tar -xJf \"${TEMP_DIR}/${ARCHIVE}\" -C \"${TEMP_DIR}\"\n"
tar -xJf "${TEMP_DIR}/${ARCHIVE}" -C "${TEMP_DIR}"

if [ ! -d "${TEMP_DIR}/Telegram" ]; then
    _echo_danger "error: \"${ARCHIVE}\" does not contain a Telegram folder\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Install binary to \"${DESTINATION}\"\n"

if [ ! -d "${DESTINATION}" ]; then
    _echo_info "mkdir -p \"${DESTINATION}\"\n"
    mkdir -p "${DESTINATION}"
fi

# copy the whole bundle, Updater must stay next to Telegram
_echo_info "cp -Rf \"${TEMP_DIR}/Telegram/.\" \"${DESTINATION}/\"\n"
cp -Rf "${TEMP_DIR}/Telegram/." "${DESTINATION}/"

_echo_info "chmod uga+x \"${DESTINATION}/${BINARY}\"\n"
chmod uga+x "${DESTINATION}/${BINARY}"

if [ -f "${DESTINATION}/Updater" ]; then
    _echo_info "chmod uga+x \"${DESTINATION}/Updater\"\n"
    chmod uga+x "${DESTINATION}/Updater"
fi

#--------------------------------------------------

_echo_warning 'Download application icon\n'

_echo_info "curl -Lf \"${ICON_URL}\" -o \"${ICON}\"\n"
if ! curl -Lf "${ICON_URL}" -o "${ICON}"; then
    _echo_warning 'Could not download the application icon, desktop entry will use a generic icon\n'
fi

#--------------------------------------------------

_echo_warning "Create symlink in \"${BIN_DIR}\"\n"

if [ ! -d "${BIN_DIR}" ]; then
    _echo_info "mkdir -p \"${BIN_DIR}\"\n"
    mkdir -p "${BIN_DIR}"
fi

_echo_info "ln -sfn \"${DESTINATION}/${BINARY}\" \"${BIN_DIR}/${APP_NAME}\"\n"
ln -sfn "${DESTINATION}/${BINARY}" "${BIN_DIR}/${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create desktop entry\n'

if [ ! -d "${APPLICATIONS_DIR}" ]; then
    _echo_info "mkdir -p \"${APPLICATIONS_DIR}\"\n"
    mkdir -p "${APPLICATIONS_DIR}"
fi

_echo_info "cat > \"${APPLICATIONS_DIR}/${DESKTOP}\" <<EOF\n"
cat > "${APPLICATIONS_DIR}/${DESKTOP}" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Telegram Desktop
GenericName=Messaging App
Comment=Official desktop application for the Telegram messaging service
Exec=${BIN_DIR}/${APP_NAME} -- %u
TryExec=${BIN_DIR}/${APP_NAME}
Icon=${ICON}
Terminal=false
Categories=Network;InstantMessaging;Qt;
MimeType=x-scheme-handler/tg;
Keywords=tg;chat;im;messaging;messenger;sms;tdesktop;
StartupWMClass=TelegramDesktop
EOF

# register tg:// links
if [ -x "$(command -v xdg-mime)" ]; then
    _echo_info "xdg-mime default \"${DESKTOP}\" x-scheme-handler/tg\n"
    xdg-mime default "${DESKTOP}" x-scheme-handler/tg
fi

if [ -x "$(command -v update-desktop-database)" ]; then
    _echo_info "update-desktop-database \"${APPLICATIONS_DIR}\"\n"
    update-desktop-database "${APPLICATIONS_DIR}"
fi

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

if [ -x "$(command -v xdg-user-dir)" ]; then
    _echo_info "cp -p \"${APPLICATIONS_DIR}/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "${APPLICATIONS_DIR}/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
else
    _echo_warning 'xdg-user-dir is not available, skipping desktop shortcut\n'
fi

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

# Check PATH and provide instructions
if ! echo "${PATH}" | grep -q "${BIN_DIR}"; then
    _echo_warning "${BIN_DIR} is not in your PATH\n"
    _echo_info "To use ${APP_NAME} from anywhere, add the following to your shell profile:\n\n"
    _echo_warning "  export PATH=\"\$PATH:${BIN_DIR}\"\n\n"
    _echo_info 'For bash, add it to ~/.bashrc or ~/.bash_profile\n'
    _echo_info 'For zsh, add it to ~/.zshrc\n'
    _echo_info "For fish, run: fish_add_path ${BIN_DIR}\n"
fi
