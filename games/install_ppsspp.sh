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
# * ppsspp
# * playstation portable emulator
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install PPSSPP'

# Old repository
# echo_info 'sudo add-apt-repository --yes ppa:ppsspp/stable'
# sudo add-apt-repository --yes ppa:ppsspp/stable
# sudo add-apt-repository --yes --remove ppa:ppsspp/stable

# Unofficial repository
echo_info 'sudo add-apt-repository --yes ppa:xuzhen666/ppsspp'
sudo add-apt-repository --yes ppa:xuzhen666/ppsspp

echo_info 'sudo apt-get update'
sudo apt-get update

# install ppsspp
echo_info 'sudo apt-get install --assume-yes ppsspp'
sudo apt-get install --assume-yes ppsspp

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/ppsspp.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /usr/share/applications/ppsspp.desktop "$(xdg-user-dir DESKTOP)"
