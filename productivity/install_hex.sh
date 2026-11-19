#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Hex
##
## Local voice dictation: hold a shortcut, speak, and Hex transcribes on your
## device then pastes into whatever app you are in. Nothing leaves your machine
## once the first speech model has been downloaded.
##
## @category productivity
## @link     https://github.com/anomalyco/hex
## @link     https://anoma.ly/hex

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=hex
DESKTOP=anomaly.hex.desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(apt-get dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

# Select the Debian package matching the host architecture
case "$(uname -m)" in
    x86_64)
        URL=https://anoma.ly/hex/download/linux-x64-deb
        ;;
    aarch64|arm64)
        URL=https://anoma.ly/hex/download/linux-arm64-deb
        ;;
    *)
        _echo_danger "error: \"$(basename "${0}")\" supports x86_64 and aarch64 only, found: $(uname -m)\n"
        exit 1
        ;;
esac

BINARY="${APP_NAME}.deb"

#--------------------------------------------------

# Hex is built against glibc 2.39 (Ubuntu 24.04, Debian 13, Fedora 40 or newer)
GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2> /dev/null | awk '{print $2}')
if [ -n "${GLIBC_VERSION}" ] && [ "$(printf '%s\n2.39\n' "${GLIBC_VERSION}" | sort -V | head -n 1)" != '2.39' ]; then
    _echo_danger "error: ${APP_NAME} requires glibc 2.39 or newer, found: ${GLIBC_VERSION}\n"
    exit 1
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Downloading file to temporary directory\n'

if [ -x "$(command -v curl)" ]; then
    # download latest version with curl
    _echo_info "curl -Lf \"${URL}\" -o \"${TEMP_DIR}/${BINARY}\"\n"
    curl -Lf "${URL}" -o "${TEMP_DIR}/${BINARY}"

elif [ -x "$(command -v wget)" ]; then
    # download latest version with wget
    _echo_info "wget -q \"${URL}\" -O \"${TEMP_DIR}/${BINARY}\"\n"
    wget -q "${URL}" -O "${TEMP_DIR}/${BINARY}"

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

# Check if the downloaded file is valid (not empty and not an HTML error page)
if [ ! -s "${TEMP_DIR}/${BINARY}" ] || head -n 1 "${TEMP_DIR}/${BINARY}" | grep -q '<!DOCTYPE html>'; then
    _echo_danger "error: Downloaded file is invalid or not found. Please check the architecture and URL.\n"
    _echo_info "Supported architectures: x86_64, aarch64\n"
    _echo_info "Your architecture: $(uname -m)\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning 'Install .deb package\n'

_echo_info "sudo dpkg -i \"${TEMP_DIR}/${BINARY}\"\n"
sudo dpkg -i "${TEMP_DIR}/${BINARY}"

#--------------------------------------------------

_echo_warning 'Fix missing dependencies if any\n'

_echo_info 'sudo apt-get install -f -y\n'
sudo apt-get install -f -y

#--------------------------------------------------

# Hex lists wl-clipboard, wtype, xdg-utils, and mesa-vulkan-drivers as
# Recommends. dpkg -i does not install Recommends, and apt-get -f only repairs
# Depends, so Wayland pastes would fail with "could not own the Wayland
# clipboard" when wl-copy is missing.
_echo_warning 'Install recommended runtime dependencies\n'

_echo_info 'sudo apt-get install -y wl-clipboard wtype xdg-utils mesa-vulkan-drivers\n'
sudo apt-get install -y wl-clipboard wtype xdg-utils mesa-vulkan-drivers

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

if [ -f "/usr/share/applications/${DESKTOP}" ]; then
    _echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

else
    _echo_warning "No desktop entry found for \"${APP_NAME}\"\n"
fi

#--------------------------------------------------

_echo_warning "Run '${APP_NAME} model install' to download a speech model before first use.\n"
