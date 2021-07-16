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
# * config known ssh hosts
# *
# * @category browser
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

echo_info 'rm -rf ~/.mozilla/firefox'
rm -rf ~/.mozilla/firefox

echo_info 'rm -rf ~/.cache/mozilla/firefox'
rm -rf ~/.cache/mozilla/firefox

# config firefox
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.mozilla\" ~"
cp -Rfv "${CONFIG_DIR}/home/.mozilla" ~
