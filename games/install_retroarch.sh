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
# * retroarch
# *
# * @category games
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info 'sudo add-apt-repository --yes ppa:libretro/stable\n'
sudo add-apt-repository --yes ppa:libretro/stable

echo_info 'sudo apt-get install --assume-yes retroarch\n'
sudo apt-get install --assume-yes retroarch

echo_info "wget https://buildbot.libretro.com/stable/1.15.0/linux/x86_64/RetroArch_cores.7z\n"
wget https://buildbot.libretro.com/stable/1.15.0/linux/x86_64/RetroArch_cores.7z

echo_info "7z e RetroArch_cores.7z -o\"${HOME}/.config/retroarch/cores/\"\n"
7z e RetroArch_cores.7z -o"${HOME}/.config/retroarch/cores/"

echo_info 'rm RetroArch_cores.7z\n'
rm RetroArch_cores.7z

echo_info 'find ~/.config/retroarch/cores/* -type d -delete\n'
find ~/.config/retroarch/cores/* -type d -delete

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/retroarch.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/retroarch.desktop "$(xdg-user-dir DESKTOP)"
