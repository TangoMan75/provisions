#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## android-sdk-tools
##
## @category android
## @link     https://developer.android.com/studio#downloads

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install android-sdk-tools'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
    exit 1
fi

_echo_info 'wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip\n'
wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

_echo_info 'unzip sdk-tools-linux-4333796.zip -d ./\n'
unzip sdk-tools-linux-4333796.zip -d ./

_echo_info 'mv ./tools ~/.android-sdk-tools\n'
mv ./tools ~/.android-sdk-tools

_echo_info 'rm -f ./sdk-tools-linux-4333796.zip\n'
rm -f ./sdk-tools-linux-4333796.zip

