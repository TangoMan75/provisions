#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ide-url-handler
##
## @link     https://github.com/TangoMan75/ide-url-handler
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install TangoMan75 ide-url-handler'

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

_echo_info "sudo sh -c \"\$(wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh -O -) install\"\n"
sudo sh -c "$(wget -q https://raw.githubusercontent.com/TangoMan75/ide-url-handler/master/install.sh -O -) install"

