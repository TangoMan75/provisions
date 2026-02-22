#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## A short description
##
## ```
## # example usage
## template -f foobar
## ```
##
## @category template
## @link     https://github.com/TangoMan75/template

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template
DESKTOP="${APP_NAME}".desktop

#--------------------------------------------------

PPA=ppa:tangoman75/template.ppa # optional

#--------------------------------------------------

KEYRING_URL=https://tangoman.io/keyrings #optional
KEYRING="${APP_NAME}.gpg" #optional

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Install ppa\n' # optional

_echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
sudo add-apt-repository --yes "${PPA}"

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
_echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

_echo_warning 'Install gpg key\n' # optional

_echo_info "wget -qO- \"${KEYRING_URL}/${KEYRING}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}/${KEYRING}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"

_echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" /etc/apt/keyrings/${KEYRING}\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" /etc/apt/keyrings/${KEYRING}

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main\" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null

_echo_info "rm -f \"${TEMP_DIR}/${KEYRING}\"\n"
rm -f "${TEMP_DIR}/${KEYRING}"

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop\n'

_echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

#--------------------------------------------------

# this is only useful when installing cli tools
_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync
