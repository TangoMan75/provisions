#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## nessus
##
## network scanner
##
## for kali download version: Nessus-8.3.1-debian6_amd64.deb
## for ubuntu download version: Nessus-8.3.1-ubuntu1110_amd64.deb
## connect to https://localhot:8834
##
## @category security
## @link     https://www.tenable.com/downloads/nessus

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install nessus'

APP_VERSION='Nessus-8.3.1-debian6_amd64.deb'

if [ -e "${APP_VERSION}" ]; then
    _echo_info "dpkg --install ${APP_VERSION}\n"
    dpkg --install ${APP_VERSION}

    # autostart
    _echo_info '/etc/init.d/nessusd start\n'
    /etc/init.d/nessusd start

    _echo_info 'update-rc.d nessusd enable\n'
    update-rc.d nessusd enable
else
    _echo_danger "error: cannot install, \"${APP_VERSION}\" not found\n"
fi

