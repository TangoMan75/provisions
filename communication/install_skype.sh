#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## skype
##
## @category communication

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'\n"
    exit 1
fi

_echo_info 'sudo snap install skype --classic\n'
sudo snap install skype --classic
