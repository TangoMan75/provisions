#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## optipng
##
## cli image optimizer
##
## ```bash
## $ optipng <filename>.png
## ```
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install optipng'

_echo_info 'sudo apt-get install --assume-yes optipng\n'
sudo apt-get install --assume-yes optipng
