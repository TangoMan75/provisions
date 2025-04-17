#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## jmtpfs
##
## Allows to mount android file system over usb
##
## @category drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

echo_info 'sudo apt-get install --assume-yes jmtpfs\n'
sudo apt-get install --assume-yes jmtpfs

