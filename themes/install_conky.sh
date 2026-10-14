#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## conky
## widget gnome system monitor
##
## @category themes
## @license  MIT
## @link     https://askubuntu.com/questions/1014263/is-there-any-widget-that-can-show-my-cpu-and-other-performances-live

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

_echo_info 'sudo apt-get install --assume-yes conky\n'
sudo apt-get install --assume-yes conky

# # autostart
# cat > ~/.config/autostart/conky.desktop <<EOF
# [Desktop Entry]
# Name=Conky
# Comment=Moniteur système
# Exec=conky &
# Terminal=false
# Type=Application
# Icon=gnome-monitor
# Categories=System;
# StartupNotify=false
# EOF

# config
_echo_info 'mkdir -p ~/.config/conky\n'
mkdir -p ~/.config/conky

# _echo_info 'cp /etc/conky/conky.conf ~/.config/conky/\n'
# cp /etc/conky/conky.conf ~/.config/conky/

_echo_info "sudo cp -fv \"${CONFIG_DIR}/home/.config/conky/conky.conf ~/.config/conky/\"\n"
sudo cp -fv "${CONFIG_DIR}/home/.config/conky/conky.conf ~/.config/conky/"
