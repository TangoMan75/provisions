#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Signal Desktop
##
## Signal Desktop is the official desktop client for the Signal private
## messaging service. It lets you send end-to-end encrypted messages,
## make voice and video calls, and share files from your computer,
## synced with the Signal account on your phone.
##
## ```
## # launch from terminal
## signal-desktop
## ```
##
## @category communication
## @link     https://signal.org/download/linux/
## @link     https://github.com/signalapp/Signal-Desktop
## @link     https://support.signal.org/hc/articles/360008216551-Installing-Signal

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(gpg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y gnupg'\n"
        exit 1
    fi
done

#--------------------------------------------------

APP_NAME=signal-desktop
DESKTOP="${APP_NAME}.desktop"

#--------------------------------------------------

KEYRING_URL=https://updates.signal.org/desktop/apt/keys.asc
KEYRING="${APP_NAME}-keyring.gpg"
KEYRING_PATH="/usr/share/keyrings/${KEYRING}"

#--------------------------------------------------

SOURCES_URL=https://updates.signal.org/static/desktop/apt/${APP_NAME}.sources
SOURCES="${APP_NAME}.sources"
SOURCES_FILE="/etc/apt/sources.list.d/${SOURCES}"

#--------------------------------------------------

# Signal Desktop only publishes amd64 packages on its APT repository
case "$(uname -m)" in
    x86_64|amd64)
        ;;
    *)
        _echo_danger "error: no Signal Desktop package for \"$(uname -m)\", use the AppImage instead: 'https://signal.org/download/linux/'\n"
        exit 1
        ;;
esac

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning "Download Signal signing key\n"

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL \"${KEYRING_URL}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
    curl -fsSL "${KEYRING_URL}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"
elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- \"${KEYRING_URL}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
    wget -qO- "${KEYRING_URL}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"
else
    _echo_danger "error: \"$(basename "${0}")\" requires curl or wget, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

# Check the dearmored key is valid (not empty and parseable by gpg)
if [ ! -s "${TEMP_DIR}/${KEYRING}" ] || ! gpg --show-keys --with-colons "${TEMP_DIR}/${KEYRING}" > /dev/null 2>&1; then
    _echo_danger "error: Failed to download Signal signing key, check: \"${KEYRING_URL}\"\n"
    exit 1
fi

#--------------------------------------------------

_echo_warning "Install Signal signing key to \"${KEYRING_PATH}\"\n"

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" \"${KEYRING_PATH}\"\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" "${KEYRING_PATH}"

#--------------------------------------------------

_echo_warning "Register Signal APT repository\n"

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL \"${SOURCES_URL}\" -o \"${TEMP_DIR}/${SOURCES}\"\n"
    curl -fsSL "${SOURCES_URL}" -o "${TEMP_DIR}/${SOURCES}"
else
    _echo_info "wget -q \"${SOURCES_URL}\" -O \"${TEMP_DIR}/${SOURCES}\"\n"
    wget -q "${SOURCES_URL}" -O "${TEMP_DIR}/${SOURCES}"
fi

# Check the retrieved deb822 definition is valid and points to the installed keyring
if [ ! -s "${TEMP_DIR}/${SOURCES}" ] || ! grep -q "^Types:" "${TEMP_DIR}/${SOURCES}"; then
    _echo_danger "error: Retrieved sources file is invalid, check: \"${SOURCES_URL}\"\n"
    exit 1
fi

if ! grep -q "^Signed-By: ${KEYRING_PATH}$" "${TEMP_DIR}/${SOURCES}"; then
    _echo_warning "Sources file does not reference \"${KEYRING_PATH}\", Signature verification may fail\n"
fi

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${SOURCES}\" \"${SOURCES_FILE}\"\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${SOURCES}" "${SOURCES_FILE}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

if [ -f "/usr/share/applications/${DESKTOP}" ] && [ -x "$(command -v xdg-user-dir)" ]; then
    _echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
else
    _echo_warning "Desktop entry \"${DESKTOP}\" not found, skipping desktop shortcut\n"
fi
