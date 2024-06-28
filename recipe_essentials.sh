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
# * recipe essentials
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) echo_warning "$(basename "${0}")";
            echo_label 14 '  description:'; echo_primary 'Recipe to provision essential applications'
            echo_label 14 '  usage:'; echo_primary "$(basename "${0}") -n (no-update) -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update.sh
    ./upgrade.sh
fi

#/**
# * system essentials
# * these will most likely be required
# */

./dev/install_python3-pip.sh
./network/install_curl.sh
./system/install_make.sh

#/**
# * system extra
# */

# gparted: partition manager
./system/install_gparted.sh
# tweaks for gnome desktop
./system/install_gnome-tweaks.sh

#/**
# * network essentials
# */

# git
./dev/install_git.sh
./dev/config_git.sh

#/**
# * office essentials
# */

# chrome: browser
./browser/install_chrome.sh
# text editor
./ide/config_sublime-text.sh
./ide/install_sublime-text.sh
# vlc: music/video player
./multimedia/install_vlc.sh
# libreoffice-calc: spread sheet editor
./office/install_libreoffice-calc.sh
# libreoffice-writer: rich text editor
./office/install_libreoffice-writer.sh
# gnome-clocks: alarm & world clock
./productivity/install_gnome-clocks.sh
# gnome-weather
./productivity/install_gnome-weather.sh

#/**
# * utils
# */

# p7zip-full: archive manager
./utils/install_p7zip-full.sh
# unrar: archive manager
./utils/install_unrar.sh

#/**
# * config
# */

./system/config_grub.sh
./system/config_keyboard.sh

# dconf-editor: gnome configuration manager
./system/install_dconf-editor.sh
./system/config_gnome_dconf.sh
