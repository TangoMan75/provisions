#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * multisystem
# * create bootable usb drives
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

sudo "apt-add-repository 'deb http://liveusb.info/multisystem/depot all main'"
sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main'

echo_info 'wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -'
wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes multisystem'
sudo apt-get install --assume-yes multisystem
