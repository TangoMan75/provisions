#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove grub-customizer
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get purge --assume-yes grub-customizer\n'
sudo apt-get purge --assume-yes grub-customizer

echo_info 'sudo add-apt-repository --remove --yes ppa:danielrichter2007/grub-customizer\n'
sudo add-apt-repository --remove --yes ppa:danielrichter2007/grub-customizer
