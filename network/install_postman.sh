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
# * postman
# *
# * API Rest client
# *
# * @category network
# * @link     https://www.getpostman.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

APP_NAME=postman

alert_primary "Install \"${APP_NAME}\""

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

echo_info "sudo snap install ${APP_NAME}"
sudo snap install ${APP_NAME}

# create shortcut on desktop
echo_info "cp -p /var/lib/snapd/desktop/applications/${APP_NAME}_${APP_NAME}.desktop \"$(xdg-user-dir DESKTOP)\""
cp -p /var/lib/snapd/desktop/applications/${APP_NAME}_${APP_NAME}.desktop "$(xdg-user-dir DESKTOP)"

