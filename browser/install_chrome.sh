#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## chrome
## web browser
##
## @category browser

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install Chrome'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    exit 1
fi

#--------------------------------------------------

KEYRING_URL=https://dl-ssl.google.com/linux/linux_signing_key.pub
KEYRING=google-chrome.gpg

#--------------------------------------------------

_echo_info 'sudo mkdir -p -m 755 /etc/apt/keyrings\n'
sudo mkdir -p -m 755 /etc/apt/keyrings

# install the gpg key in a dedicated keyring (apt-key is gone since Debian 12 / Ubuntu 24.04)
_echo_info "wget -qO- \"${KEYRING_URL}\" | sudo gpg --batch --yes --dearmor -o \"/etc/apt/keyrings/${KEYRING}\"\n"
wget -qO- "${KEYRING_URL}" | sudo gpg --batch --yes --dearmor -o "/etc/apt/keyrings/${KEYRING}"

_echo_info "echo \"deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://dl.google.com/linux/chrome/deb/ stable main\" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null\n"
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/${KEYRING}] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes google-chrome-stable\n'
sudo apt-get install --assume-yes google-chrome-stable

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/google-chrome.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/google-chrome.desktop "$(xdg-user-dir DESKTOP)"
