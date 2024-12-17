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
# * gnome-tweaks
# *
# * Tweaks for gnome desktop
# *
# * @note     gnome-tweak-tool is an alias for gnome-tweaks
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install gnome-tweaks'

echo_info 'sudo apt-get install --assume-yes gnome-tweaks\n'
sudo apt-get install --assume-yes gnome-tweaks

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.gnome.tweaks.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.gnome.tweaks.desktop "$(xdg-user-dir DESKTOP)"

