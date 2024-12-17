#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * chrome
# * web browser
# *
# * @category browser
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Chrome'

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info 'sudo sh -c echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list\n'
sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'

echo_info 'wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -\n'
wget -qO - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes google-chrome-stable\n'
sudo apt-get install --assume-yes google-chrome-stable

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/google-chrome.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/google-chrome.desktop "$(xdg-user-dir DESKTOP)"
