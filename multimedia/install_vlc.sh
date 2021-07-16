#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * vlc
# * multimedia player
# *
# * @category multimedia
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install VLC'

echo_info 'sudo apt-get install --assume-yes vlc'
sudo apt-get install --assume-yes vlc

# create desktop shortcut
cat > ~/Desktop/vlc.desktop<<EOF
[Desktop Entry]
Version=1.0
Name=VLC media player
GenericName=Media player
Comment=Read, capture, broadcast your multimedia streams
Exec=/usr/bin/vlc --started-from-file %U
Icon=vlc
Terminal=false
Type=Application
Categories=AudioVideo;Player;Recorder;
Keywords=Player;Capture;DVD;Audio;Video;Server;Broadcast;
EOF
