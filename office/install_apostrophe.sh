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
# * apostrophe
# *
# * markdown editor
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes apostrophe\n'
sudo apt-get install --assume-yes apostrophe

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/org.gnome.gitlab.somas.Apostrophe.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/org.gnome.gitlab.somas.Apostrophe.desktop "$(xdg-user-dir DESKTOP)"
