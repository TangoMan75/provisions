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
# * install libre office calc
# * 
# * Remove spelling
# * Tools > Automatic Spell Checking Shift+F7
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install libreoffice-calc'

echo_info 'sudo apt-get install --assume-yes libreoffice-calc\n'
sudo apt-get install --assume-yes libreoffice-calc

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/libreoffice-calc.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/libreoffice-calc.desktop "$(xdg-user-dir DESKTOP)"

