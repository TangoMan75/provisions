#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe essentials
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

UPDATE=true
OPTIND=0
while getopts :nh OPTION; do
    case "${OPTION}" in
        n) UPDATE=false;;
        h) _echo_warning "$(basename "${0}")";
            _echo_success 'description:' 2 14; _echo_primary 'Recipe to provision essential applications\n'
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -n (no-update) -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done
if [ "${UPDATE}" = true ]; then
    ./update_upgrade.sh
fi

## system essentials
## these will most likely be required

./dev/install_python3-pip.sh
./network/install_curl.sh
./system/install_make.sh

## system extra

# gparted: partition manager
./system/install_gparted.sh

## office essentials

# chrome: browser
./browser/install_chrome.sh
# text editor
./ide/config_sublime-text.sh
./ide/install_sublime-text.sh
# vlc: music/video player
./multimedia/install_vlc.sh
# libreoffice-calc: spread sheet editor
./productivity/install_libreoffice-calc.sh
# libreoffice-writer: rich text editor
./productivity/install_libreoffice-writer.sh
# gnome-clocks: alarm & world clock
./productivity/install_gnome-clocks.sh
# gnome-weather
./productivity/install_gnome-weather.sh
# flameshot: screenshot app
./graphics/install_flameshot.sh

## config

./system/config_keyboard.sh

# dconf-editor: gnome configuration manager
./system/install_dconf-editor.sh
./system/config_gnome_dconf.sh
