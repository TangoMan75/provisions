#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * proton
# *
# * @category games
# * @link     https://www.protondb.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install proton'

echo_info 'sudo add-apt-repository --yes ppa:proton-team/proton\n'
sudo add-apt-repository --yes ppa:proton-team/proton

echo_info 'sudo apt-get install --assume-yes proton\n'
sudo apt-get install --assume-yes proton
