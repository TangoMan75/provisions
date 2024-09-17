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
# * remove wine
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'rm -r ~/.wine'
rm -r ~/.wine

echo_info 'rm ~/.config/menus/applications-merged/wine*'
rm ~/.config/menus/applications-merged/wine*

echo_info 'rm -r ~/.local/share/applications/wine'
rm -r ~/.local/share/applications/wine

echo_info 'rm ~/.local/share/desktop-directories/wine*'
rm ~/.local/share/desktop-directories/wine*

echo_info 'rm ~/.local/share/icons/????_*.xpm'
rm ~/.local/share/icons/????_*.xpm

# remove keys
echo_info 'sudo rm -f /etc/apt/keyrings/winehq-archive.key'
sudo rm -f /etc/apt/keyrings/winehq-archive.key

echo_info "sudo rm -f /etc/apt/sources.list.d/archive*"
sudo rm -f /etc/apt/sources.list.d/archive*

echo_info "sudo rm -f /etc/apt/sources.list.d/winehq-$(lsb_release -cs).sources"
sudo rm -f /etc/apt/sources.list.d/winehq-"$(lsb_release -cs)".sources

# remove lib
echo_info 'sudo apt-get remove --purge --assume-yes lib32z1'
sudo apt-get remove --purge --assume-yes lib32z1

# remove wine
if [ -x "$(command -v aptitude)" ]; then
    echo_info 'sudo aptitude purge -y winehq-stable'
    sudo aptitude purge -y winehq-stable
fi

echo_info 'sudo apt-get remove --purge --assume-yes wine32'
sudo apt-get remove --purge --assume-yes wine32

echo_info 'sudo apt-get remove --purge --assume-yes wine'
sudo apt-get remove --purge --assume-yes wine

echo_info 'sudo apt-get remove --purge --assume-yes wine-stable'
sudo apt-get remove --purge --assume-yes wine-stable

echo_info 'sudo apt-get purge -y winehq'
sudo apt-get purge -y winehq

echo_info 'sudo apt-get purge -y winehq-stable'
sudo apt-get purge -y winehq-stable

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get autoclean'
sudo apt-get autoclean

echo_info 'sudo apt-get clean'
sudo apt-get clean

echo_info 'sudo apt-get autoremove'
sudo apt-get autoremove

