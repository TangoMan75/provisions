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
# * openjdk-11-jdk
# *
# * Java JDK
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes openjdk-11-jdk\n'
sudo apt-get install --assume-yes openjdk-11-jdk
