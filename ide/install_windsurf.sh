#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## windsurf
## AI IDE
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

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    return 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires gpg, try: 'sudo apt-get install -y gpg'\n"
    return 1
fi

echo_info 'wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg\n'
wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg

echo_info 'sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg\n'
sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg

echo_info 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null\n'
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null

echo_info 'rm -f windsurf-stable.gpg\n'
rm -f windsurf-stable.gpg

echo_info 'sudo apt install apt-transport-https\n'
sudo apt install apt-transport-https

echo_info 'sudo apt update\n'
sudo apt update

echo_info 'sudo apt install windsurf\n'
sudo apt install windsurf

#--------------------------------------------------

# create shortcut on desktop
echo_info "cp -p \"/usr/share/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/usr/share/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

