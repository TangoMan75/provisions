#!/bin/bash

#/*
## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>>

##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zenmap
## nmap network scanner graphic interface
##
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger "Uninstall $(basename "${ZENMAP}" .rpm)"

_echo_info 'sudo apt-get remove -y python-gtk2\n'
sudo apt-get remove -y python-gtk2

_echo_info 'sudo apt-get remove -y python-gobject-2\n'
sudo apt-get remove -y python-gobject-2

_echo_info 'sudo apt-get remove -y python-cairo\n'
sudo apt-get remove -y python-cairo

_echo_info 'sudo apt-get remove -y python2\n'
sudo apt-get remove -y python2

_echo_info 'sudo apt-get remove -y zenmap\n'
sudo apt-get remove -y zenmap

_echo_info 'sudo apt-get autoremove -y\n'
sudo apt-get autoremove -y
