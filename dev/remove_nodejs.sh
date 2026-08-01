#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove nodejs
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# uninstall nodejs
_alert_secondary 'uninstall nodejs'

_echo_info 'sudo apt-get purge --assume-yes yarn\n'
sudo apt-get purge --assume-yes yarn

_echo_info 'sudo apt-get purge --assume-yes npm\n'
sudo apt-get purge --assume-yes npm

_echo_info 'sudo apt-get purge --assume-yes nodejs\n'
sudo apt-get purge --assume-yes nodejs

_echo_info 'rm -rf /etc/apt/sources.list.d/nodesource.list\n'
rm -rf /etc/apt/sources.list.d/nodesource.list

_echo_info 'rm -rf /etc/apt/keyrings/nodesource.gpg\n'
rm -rf /etc/apt/keyrings/nodesource.gpg

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove
