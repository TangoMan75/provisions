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
# * nessus
# *
# * network scanner
# *
# * for kali download version: Nessus-8.3.1-debian6_amd64.deb
# * for ubuntu download version: Nessus-8.3.1-ubuntu1110_amd64.deb
# * connect to https://localhot:8834
# *
# * @category security
# * @link     https://www.tenable.com/downloads/nessus
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install nessus'

APP_VERSION='Nessus-8.3.1-debian6_amd64.deb'

if [ -e "${APP_VERSION}" ]; then
    echo_info "dpkg -i ${APP_VERSION}"
    dpkg -i ${APP_VERSION}

    # autostart
    echo_info '/etc/init.d/nessusd start'
    /etc/init.d/nessusd start

    echo_info 'update-rc.d nessusd enable'
    update-rc.d nessusd enable
else
    echo_error "cannot install, \"${APP_VERSION}\" not found"
fi
