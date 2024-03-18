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
# * yq
# *
# * command-line yaml/xml processor - jq wrapper for yaml and xml documents
# *
# * @category dev
# * @link     https://yq.readthedocs.io/en/latest
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v pip3)" ]; then
    echo_error "\"$(basename "${0}")\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'"
    exit 1
fi

alert_primary 'Install yq'

echo_info 'pip3 install yq'
pip3 install yq
