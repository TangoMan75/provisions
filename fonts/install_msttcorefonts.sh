#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install msttcorefonts
##
## @category fonts
## @license  MIT
## @link     https://github.com/powerline/fonts

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes msttcorefonts\n'
sudo apt-get install --assume-yes msttcorefonts

_echo_info 'sudo apt-get install --assume-yes ttf-mscorefonts-installer\n'
sudo apt-get install --assume-yes ttf-mscorefonts-installer
