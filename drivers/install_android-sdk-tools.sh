#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * android-sdk-tools
# *
# * @category drivers
# * @link     https://developer.android.com/studio#downloads
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v unzip)" ]; then
    echo_error "\"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'"
    exit 1
fi

echo_info 'wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip'
wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

echo_info 'unzip sdk-tools-linux-4333796.zip -d ./'
unzip sdk-tools-linux-4333796.zip -d ./

echo_info 'mv ./tools ~/.android-sdk-tools'
mv ./tools ~/.android-sdk-tools

echo_info 'rm -f ./sdk-tools-linux-4333796.zip'
rm -f ./sdk-tools-linux-4333796.zip

