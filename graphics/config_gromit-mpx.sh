#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config gromit-mpx
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

_alert_secondary 'Config gromit-mpx'

_echo_info "cp -Rfv \"${CONFIG_DIR}/home/.var/app/net.christianbeier.Gromit-MPX\" ~/.var/app/net.christianbeier.Gromit-MPX\n"
cp -Rfv "${CONFIG_DIR}/home/.var/app/net.christianbeier.Gromit-MPX" ~/.var/app/net.christianbeier.Gromit-MPX

