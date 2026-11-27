#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## pritunl
##
## Open source VPN server and client
##
## @category security
## @link     https://pritunl.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=pritunl
DESKTOP=pritunl-client-electron.desktop

#--------------------------------------------------

REPO_URL=https://repo.pritunl.com/stable/apt
KEYRING_URL=https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc
KEYRING="${APP_NAME}.gpg"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gnupg, try: 'sudo apt-get install -y gnupg'\n"
    exit 1
fi

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Install gpg key\n'

_echo_info "curl -fsSL \"${KEYRING_URL}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
curl -fsSL "${KEYRING_URL}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" /etc/apt/keyrings/${KEYRING}\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" /etc/apt/keyrings/${KEYRING}

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${REPO_URL} noble main\" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${REPO_URL} noble main" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null

#--------------------------------------------------

_echo_info "rm -rf \"${TEMP_DIR}\"\n"
rm -rf "${TEMP_DIR}"

#--------------------------------------------------

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info "sudo apt-get install --assume-yes ${APP_NAME}-client-electron\n"
sudo apt-get install --assume-yes ${APP_NAME}-client-electron

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"
