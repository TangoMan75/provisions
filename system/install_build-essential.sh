#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## build-essentials
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get -y install autoconf\n'
sudo apt-get -y install autoconf

echo_info 'sudo apt-get -y install build-essential\n'
sudo apt-get -y install build-essential

echo_info 'sudo apt-get -y install libssl-dev\n'
sudo apt-get -y install libssl-dev

echo_info 'sudo apt-get -y install libxml2-dev\n'
sudo apt-get -y install libxml2-dev

echo_info 'sudo apt-get -y install libxslt-dev\n'
sudo apt-get -y install libxslt-dev

echo_info 'sudo apt-get -y install ruby-dev\n'
sudo apt-get -y install ruby-dev
