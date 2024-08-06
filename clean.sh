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
# * clean apt
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

# shellcheck source=/dev/null
. "${CURDIR}"/tools/src/colors/colors.sh

alert_secondary 'Clean'

echo_info 'sudo apt-get purge'
sudo apt-get purge

echo_info 'sudo apt -y autoremove --purge'
sudo apt -y autoremove --purge

# remove /var/cache/apt/archives
echo_info 'sudo apt-get clean'
sudo apt-get clean
