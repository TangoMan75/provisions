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
# * bash_aliases
# *
# * @category system
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install bash_aliases'

if [ ! -x "$(command -v git)" ]; then
    echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

echo_info 'git clone --depth 1 https://github.com/TangoMan75/bash_aliases ~/.tangoman/bash_aliases'
git clone --depth 1 https://github.com/TangoMan75/bash_aliases ~/.tangoman/bash_aliases

echo_info '(cd ~/.tangoman/bash_aliases && make install)'
(cd ~/.tangoman/bash_aliases && make install)
