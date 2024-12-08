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
# * digikam
# * photo manager
# *
# * @category graphics
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install digikam'

echo_info 'sudo apt-get install --assume-yes digikam\n'
sudo apt-get install --assume-yes digikam

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.kde.digikam.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.kde.digikam.desktop "$(xdg-user-dir DESKTOP)"
