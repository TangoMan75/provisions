#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## obs studio
## Free and open source software for video recording and live streaming
##
## @category multimedia
## @link     https://obsproject.com/wiki/install-instructions#linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install OBS Studio'

_echo_info 'sudo add-apt-repository --yes ppa:obsproject/obs-studio\n'
sudo add-apt-repository --yes ppa:obsproject/obs-studio

_echo_info 'sudo apt-get update\n'
sudo apt-get update

_echo_info 'sudo apt-get install --assume-yes ffmpeg\n'
sudo apt-get install --assume-yes ffmpeg

_echo_info 'sudo apt-get install --assume-yes obs-studio\n'
sudo apt-get install --assume-yes obs-studio

_echo_info 'cp round-image-mask.png ~/Pictures\n'
cp round-image-mask.png ~/Pictures

# create shortcut on desktop
_echo_info "cp -p /usr/share/applications/com.obsproject.Studio.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/com.obsproject.Studio.desktop "$(xdg-user-dir DESKTOP)"

