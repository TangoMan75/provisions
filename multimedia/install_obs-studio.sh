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
# * obs studio
# * Free and open source software for video recording and live streaming
# *
# * @category multimedia
# * @link     https://obsproject.com/wiki/install-instructions#linux
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install OBS Studio'

echo_info 'sudo add-apt-repository --yes ppa:obsproject/obs-studio'
sudo add-apt-repository --yes ppa:obsproject/obs-studio

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes ffmpeg'
sudo apt-get install --assume-yes ffmpeg

echo_info 'sudo apt-get install --assume-yes obs-studio'
sudo apt-get install --assume-yes obs-studio

echo_info 'cp round-image-mask.png ~/Pictures'
cp round-image-mask.png ~/Pictures

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/com.obsproject.Studio.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/com.obsproject.Studio.desktop "$(xdg-user-dir DESKTOP)"

