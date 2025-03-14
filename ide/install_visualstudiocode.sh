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
## outline > secondary side bar
##
## @category ide
## @link     https://code.visualstudio.com/download

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Visual Studio Code'

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

echo_info 'sudo snap install code --classic\n'
sudo snap install code --classic

echo_info "cp -p /var/lib/snapd/desktop/applications/code_code.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /var/lib/snapd/desktop/applications/code_code.desktop "$(xdg-user-dir DESKTOP)"

