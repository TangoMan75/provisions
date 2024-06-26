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
# * ide-url-handler
# *
# * @link     https://github.com/TangoMan75/ide-url-handler
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install TangoMan75 ide-url-handler'

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info "sudo sh -c \"\$(wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh -O -) install\""
sudo sh -c "$(wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh -O -) install"
