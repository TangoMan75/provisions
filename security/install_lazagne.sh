#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## LaZagne
##
## recover locally stored passwords
##
## @category security
## @link     https://github.com/AlessandroZ/LaZagne

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install LaZagne'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi


if [ ! -x "$(command -v unzip)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

_echo_info 'wget -q https://github.com/AlessandroZ/LaZagne/releases/download/1.0/Linux-64bits.zip\n'
wget -q https://github.com/AlessandroZ/LaZagne/releases/download/1.0/Linux-64bits.zip

_echo_info 'unzip Linux-64bits.zip -d ./\n'
unzip Linux-64bits.zip -d ./

_echo_info 'mv ./Linux-64bits ~/.LaZagne\n'
mv ./Linux-64bits ~/.LaZagne

_echo_info 'chmod 755 ~/.LaZagne/LaZagne-64bits\n'
chmod 755 ~/.LaZagne/LaZagne-64bits

_echo_info 'rm -f ./Linux-64bits.zip\n'
rm -f ./Linux-64bits.zip

