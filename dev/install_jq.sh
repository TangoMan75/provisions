#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## jq
## jq is a lightweight and flexible command-line json processor
##
## @category dev
## @link     https://stedolan.github.io/jq

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install jq'

_echo_info 'sudo apt-get install --assume-yes jq\n'
sudo apt-get install --assume-yes jq
