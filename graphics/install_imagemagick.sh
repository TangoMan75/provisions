#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## imagemagick
##
## convert images,
## extract exif info from image file
##
## ```bash
## $ convert -resize 50% myfigure.png myfigure.jpg
## ```
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install imagemagick'

_echo_info 'sudo apt-get install --assume-yes imagemagick\n'
sudo apt-get install --assume-yes imagemagick
