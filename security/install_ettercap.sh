#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ettercap
##
## Man in the middle attack suite
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAMES='ettercap-common ettercap-graphical'

alert_primary "Install ${APP_NAMES}"

# --------------------------------------------------

for APP_NAME in ${APP_NAMES}; do
    echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
    sudo apt-get install --assume-yes "${APP_NAME}"
done

