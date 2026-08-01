#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## waydroid
##
## Run android apks
##
## ```
## sudo waydroid init
## waydroid first-launch
## waydroid app install ~/apps/com.darkempire78.opencalculator.apk
## waydroid app launch com.darkempire78.opencalculator
## waydroid app list
## waydroid app remove com.darkempire78.opencalculator
## waydroid session stop
## ```
##
## @category android
## @link     https://waydro.id

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install waydroid'

_echo_info 'sudo apt install curl ca-certificates -y\n'
sudo apt install curl ca-certificates -y

_echo_info 'curl https://repo.waydro.id | sudo bash\n'
curl https://repo.waydro.id | sudo bash

_echo_info 'sudo apt-get install --assume-yes waydroid\n'
sudo apt-get install --assume-yes waydroid

