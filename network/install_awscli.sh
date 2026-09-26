#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## awscli
## amazon s3 client
##
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install awscli'

#--------------------------------------------------

if [ ! -x "$(command -v pip3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info 'pip3 install awscli\n'
pip3 install awscli

