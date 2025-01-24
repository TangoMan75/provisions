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
# * jhead
# * exif jpeg header manipulation tool
# *
# * @category graphics
# * @link     http://www.sentex.net/~mwandel/jhead
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install jhead'

echo_info 'sudo apt-get install --assume-yes jhead\n'
sudo apt-get install --assume-yes jhead
