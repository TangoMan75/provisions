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
# * clamav
# *
# * Virus scanner
# *
# * @category security
# * @link     https://doc.ubuntu-fr.org/clamav
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install clamav'

echo_info 'sudo apt-get install --assume-yes clamav'
sudo apt-get install --assume-yes clamav

echo_info 'sudo apt-get install --assume-yes clamtk'
sudo apt-get install --assume-yes clamtk
