#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * multisystem
# *
# * create bootable usb drives
# *
# * @deprecated
# * @category   system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes multisystem'
sudo apt-get purge --assume-yes multisystem

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

