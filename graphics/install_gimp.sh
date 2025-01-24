#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * install gimp
# * gnu image manipulation program
# *
# * @category graphics
# * @link     https://www.gimp.org
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Gimp'

echo_info 'sudo apt-get install --assume-yes gimp\n'
sudo apt-get install --assume-yes gimp

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/gimp.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/gimp.desktop "$(xdg-user-dir DESKTOP)"
