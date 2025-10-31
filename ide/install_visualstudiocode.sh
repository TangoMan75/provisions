#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Visual Studio Code
## JavaScript IDE
##
## ```
## outline > secondary side bar
## ```
## ```
## ~/.config/Code/User/keybindings.json
## ```
##
## @category ide
## @link     https://code.visualstudio.com/download

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=code
DESKTOP=code_code.desktop

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

echo_info "sudo snap install \"${APP_NAME}\" --classic\n"
sudo snap install "${APP_NAME}" --classic

#--------------------------------------------------

# create desktop shortcut
echo_info "ln -s \"/var/lib/snapd/desktop/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
ln -s "/var/lib/snapd/desktop/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

