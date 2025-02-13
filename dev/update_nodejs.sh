#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## update nodejs
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v npm)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires npm, try: 'sudo apt-get install -y npm'\n"
    exit 1
fi

alert_secondary 'Update Node'

echo_info 'sudo npm install -g n\n'
sudo npm install -g n

echo_info 'sudo n latest\n'
sudo n latest

