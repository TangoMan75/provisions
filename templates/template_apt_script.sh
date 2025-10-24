#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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
## @link     https://github.com/TangoMan75/provisions

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

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

echo_warning 'Install ppa\n' # optional

echo_info "sudo add-apt-repository --yes \"${PPA}\"\n"
sudo add-apt-repository --yes "${PPA}"

echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

TEMP_DIR=$(mktemp -d)
echo_warning "Created temporary directory: ${TEMP_DIR}\n"

#--------------------------------------------------

echo_warning 'Install gpg key\n' # optional

echo_info "wget -qO- \"${KEYRING_URL}/${KEYRING}\" | gpg --dearmor > \"${TEMP_DIR}/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}/${KEYRING}" | gpg --dearmor > "${TEMP_DIR}/${KEYRING}"

echo_info "sudo install -D -o root -g root -m 644 \"${TEMP_DIR}/${KEYRING}\" /etc/apt/keyrings/${KEYRING}\n"
sudo install -D -o root -g root -m 644 "${TEMP_DIR}/${KEYRING}" /etc/apt/keyrings/${KEYRING}

echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main\" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] ${KEYRING_URL}/apt stable main" | sudo tee /etc/apt/sources.list.d/${APP_NAME}.list > /dev/null

echo_info "rm -f \"${TEMP_DIR}/${KEYRING}\"\n"
rm -f "${TEMP_DIR}/${KEYRING}"

#--------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

echo_warning 'Create shortcut on desktop\n'

echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

