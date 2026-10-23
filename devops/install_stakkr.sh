#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## stakkr
##
## @category devops
## @link     https://stakkr.readthedocs.io

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes python3-pip\n'
sudo apt-get install --assume-yes python3-pip

_echo_info 'sudo apt-get install --assume-yes python3-setuptools\n'
sudo apt-get install --assume-yes python3-setuptools

_echo_info 'sudo apt-get install --assume-yes python3-virtualenv\n'
sudo apt-get install --assume-yes python3-virtualenv

_echo_info 'sudo apt-get install --assume-yes python3-wheel\n'
sudo apt-get install --assume-yes python3-wheel

_echo_info 'sudo python3 -m pip --no-cache-dir install stakkr\n'
sudo python3 -m pip --no-cache-dir install stakkr
