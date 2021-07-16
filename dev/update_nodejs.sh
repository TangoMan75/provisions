#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * update nodejs
# *
# * @category dev
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v npm)" ]; then
    echo_error "\"$(basename "${0}")\" requires npm, try: 'sudo apt-get install -y npm'"
    exit 1
fi

echo_info 'sudo npm install -g n'
sudo npm install -g n

echo_info 'sudo n latest'
sudo n latest

