#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## clean apt
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# shellcheck source=/dev/null
. "${CURDIR}"/tools/src/colors/colors.sh

_alert_secondary 'Clean'

_echo_info 'sudo apt-get purge\n'
sudo apt-get purge

_echo_info 'sudo apt -y autoremove --purge\n'
sudo apt -y autoremove --purge

# remove /var/cache/apt/archives
_echo_info 'sudo apt-get clean\n'
sudo apt-get clean
