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
# * awscli
# * amazon s3 client
# *
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install awscli'

if [ ! -x "$(command -v pip3)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'\n"
    exit 1
fi

echo_info 'pip3 install awscli\n'
pip3 install awscli
