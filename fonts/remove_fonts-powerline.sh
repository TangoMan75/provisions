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
# * remove fonts-powerline
# *
# * @category fonts
# * @license  MIT
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_primary 'remove powerline fonts cache'
echo_info 'apt-cache policy fonts-powerline'
apt-cache policy fonts-powerline

echo_info 'sudo apt purge -y fonts-powerline'
sudo apt purge -y fonts-powerline
