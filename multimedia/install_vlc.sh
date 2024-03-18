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
# * vlc
# * multimedia player
# *
# * Expand all folders in playlist
# * Tools -> Preferences -> All -> Playlist -> Subdirectory Behavior -> Expand
# *
# * @category multimedia
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install VLC'

echo_info 'sudo apt-get install --assume-yes vlc'
sudo apt-get install --assume-yes vlc

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/vlc.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/vlc.desktop "$(xdg-user-dir DESKTOP)"
