#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## p7zip-full
## file compression
##
## @category utils

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAME=p7zip-full

alert_primary "Install ${APP_NAME}"

# --------------------------------------------------

echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

