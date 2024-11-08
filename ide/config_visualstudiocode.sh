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
# * config visual studio code
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

alert_secondary 'Config Visual Studio Code'

# remove previous config
echo_info 'rm -rf ~/.config/Code'
rm -rf ~/.config/Code

# config visual studio code
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/Code\" ~/.config"
cp -Rfv "${CONFIG_DIR}/home/.config/Code" ~/.config

