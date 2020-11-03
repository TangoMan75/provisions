#!/bin/bash

#/**
# * conky-all
# * widget gnome system monitor
# *
# * @category system
# * @link     https://askubuntu.com/questions/1014263/is-there-any-widget-that-can-show-my-cpu-and-other-performances-live
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

CONFIG_DIR="${BASEDIR}/../config"

echo_info 'sudo apt-get install --assume-yes conky-all'
sudo apt-get install --assume-yes conky-all
