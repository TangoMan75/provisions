#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## multisystem
##
## create bootable usb drives
##
## @deprecated use woeusb instead
## @category   system
## @link       https://doc.ubuntu-fr.org/multisystem

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install multisystem'

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info "sudo apt-add-repository -y 'deb http://liveusb.info/multisystem/depot all main'\n"
sudo apt-add-repository -y 'deb http://liveusb.info/multisystem/depot all main'

echo_info 'wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -\n'
wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes multisystem\n'
sudo apt-get install --assume-yes multisystem
