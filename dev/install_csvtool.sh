#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## csvtool
## csvtool is a tool for performing manipulations on csv files from shell scripts
##
## @category dev
## @link     http://colin.maudry.com/csvtool-manual-page

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo apt-get install --assume-yes csvtool\n'
sudo apt-get install --assume-yes csvtool
