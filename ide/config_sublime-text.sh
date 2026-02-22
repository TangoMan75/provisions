#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config sublime text
##
## @category ide

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

_alert_secondary 'Config Sublime Text'

#--------------------------------------------------

# remove previous config
_echo_info 'rm -rf ~/.config/sublime-text\n'
rm -rf ~/.config/sublime-text

# config sublime text
_echo_info "cp -Rfv \"${CONFIG_DIR}/home/.config/sublime-text\" ~/.config\n"
cp -Rfv "${CONFIG_DIR}/home/.config/sublime-text" ~/.config

