#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## iftop
## display bandwidth usage on an interface by host
##
## ```
## # list network devices
## lshw -short -c network
##
## # print network traffic
## sudo iftop -i wlp2s0
## ```
##
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_primary 'Install iftop'

echo_info 'sudo apt-get install --assume-yes iftop\n'
sudo apt-get install --assume-yes iftop
