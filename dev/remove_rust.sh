#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove rust toolchain
##
## @category dev
## @link     https://rustup.rs

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Uninstall rust toolchain'

#--------------------------------------------------

if [ ! -x "$(command -v rustup)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires rustup, try: 'sudo apt-get install -y rustup'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info 'rustup self uninstall -y\n'
rustup self uninstall -y

