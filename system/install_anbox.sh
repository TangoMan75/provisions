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
# * install anbox
# *
# * @category system
# * @link     https://doc.ubuntu-fr.org/anbox
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'"
    exit 1
fi

alert_primary 'Install Anbox'

echo_info 'sudo snap install --devmode --beta anbox'
sudo snap install --devmode --beta anbox

