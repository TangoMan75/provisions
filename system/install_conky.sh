#!/bin/bash

#/**
# * conky
# * widget gnome system monitor
# *
# * @category system
# * @link     https://askubuntu.com/questions/1014263/is-there-any-widget-that-can-show-my-cpu-and-other-performances-live
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

echo_info 'sudo apt-get install --assume-yes conky'
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
echo_info 'mkdir ~/.config/conky'
mkdir ~/.config/conky

# echo_info 'cp /etc/conky/conky.conf ~/.config/conky/'
# cp /etc/conky/conky.conf ~/.config/conky/

echo_info 'sudo cp -fv ${CONFIG_DIR}/home/.config/conky/conky.conf ~/.config/conky/'
sudo cp -fv ${CONFIG_DIR}/home/.config/conky/conky.conf ~/.config/conky/
