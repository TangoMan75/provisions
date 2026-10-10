#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## clamav
##
## Virus scanner
##
## @category security
## @link     https://doc.ubuntu-fr.org/clamav

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAMES='clamav clamtk'

_alert_primary "Install ${APP_NAMES}"

#--------------------------------------------------

for APP_NAME in ${APP_NAMES}; do
    _echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
    sudo apt-get install --assume-yes "${APP_NAME}"
done

