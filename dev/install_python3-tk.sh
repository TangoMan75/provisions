#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## python3-tk
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

echo_info 'sudo apt-get install --assume-yes python3-tk\n'
sudo apt-get install --assume-yes python3-tk

echo_info 'sudo apt-get install --assume-yes python-imaging-tk\n'
sudo apt-get install --assume-yes python-imaging-tk
