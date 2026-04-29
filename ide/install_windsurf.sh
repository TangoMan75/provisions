#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## windsurf
## AI IDE
##
## ```
## windsurf --rules my-custom-instruction-file.md
## ```
##
## modular context for windsurf:
## ```markdown
## @ref/prompts/tone.md
## @ref/prompts/structure.md
## @ref/prompts/examples.md
## ```
##
## @category ide
## @link     https://windsurf.com
## @link     https://windsurf.com/download/editor

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=windsurf
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

KEYRING_URL=https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3
KEYRING="${APP_NAME}.gpg"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    return 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    return 1
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_info "wget -qO- \"${KEYRING_URL}/${KEYRING}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}/${KEYRING}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" /etc/apt/keyrings/${KEYRING}\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" /etc/apt/keyrings/${KEYRING}

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main\" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null

_echo_info "rm -f \"${TEMP_DIR}/${KEYRING}\"\n"
rm -f "${TEMP_DIR}/${KEYRING}"

#--------------------------------------------------

_echo_warning 'Ensure apt-transport-https is installed (required for https apt sources)\n'
_echo_info "sudo apt-get install --assume-yes apt-transport-https\n"
sudo apt-get install --assume-yes apt-transport-https

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Cleaning up temporary files\n'

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

# create shortcut on desktop
_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

