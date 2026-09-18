#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove resvg
##
## @category   cli
## @link       https://github.com/linebender/resvg

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=resvg
BINARY="/usr/bin/${APP_NAME}"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ -f "${BINARY}" ]; then
    _echo_info "sudo rm -f \"${BINARY}\"\n"
    sudo rm -f "${BINARY}"
else
    _echo_warning "${BINARY} not found, nothing to remove\n"
fi
