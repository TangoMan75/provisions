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
# * audacity
# *
# * @category multimedia
# * @note     Shift + play button to loop selection
# * @note     Stop following cursor : Edit > Preferences > Tracks > Auto-scroll if head unpinned (uncheck)
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install audacity'

echo_info 'sudo apt-get install --assume-yes audacity\n'
sudo apt-get install --assume-yes audacity

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/audacity.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/audacity.desktop "$(xdg-user-dir DESKTOP)"

