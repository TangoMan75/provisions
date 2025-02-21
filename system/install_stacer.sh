#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## stacer
##
## system optimizer and monitor
##
## @category system
## @link     https://github.com/oguzhaninan/Stacer

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install stacer'

echo_info 'sudo apt-get install --assume-yes stacer\n'
sudo apt-get install --assume-yes stacer

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/stacer.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/stacer.desktop "$(xdg-user-dir DESKTOP)"

