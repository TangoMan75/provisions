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

_echo_info 'sudo sh -c echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list\n'
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

_echo_info 'wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -\n'
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes google-chrome-stable\n'
sudo apt-get install --assume-yes google-chrome-stable

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/google-chrome.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/google-chrome.desktop "$(xdg-user-dir DESKTOP)"
