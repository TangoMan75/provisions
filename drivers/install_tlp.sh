#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install tlp
##
## Enable power saving features
## Edit settings here: /etc/default/tlp
## Then reboot or `sudo tlp start`
## You may also want the packages *"thermald"*, *"lm-sensors"* and *"psensor"*
## https://doc.ubuntu-fr.org/tlp
##
## @category drivers
## @link     https://erdnaxe.github.io/dell-g3-17-ubuntu

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes tlp\n'
sudo apt-get install --assume-yes tlp

_echo_info 'sudo apt-get install --assume-yes tlp-rdw\n'
sudo apt-get install --assume-yes tlp-rdw

_echo_info 'sudo systemctl enable tlp\n'
sudo systemctl enable tlp

_echo_info 'sudo systemctl enable tlp-sleep\n'
sudo systemctl enable tlp-sleep

_echo_info 'sudo tlp start\n'
sudo tlp start
