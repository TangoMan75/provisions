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
# * config sublime text
# *
# * @category ide
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

CONFIG_DIR="${CURDIR}/../config"

alert_secondary 'Config Sublime Text'

# remove previous config
echo_info 'rm -rf ~/.config/sublime-text'
rm -rf ~/.config/sublime-text

# config sublime text
echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/sublime-text\" ~/.config"
cp -Rfv "${CONFIG_DIR}/home/.config/sublime-text" ~/.config

