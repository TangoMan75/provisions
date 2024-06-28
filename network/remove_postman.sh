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
# * @category network
# * @link     https://dbeaver.io
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

APP_NAME=postman

alert_primary "Remove ${APP_NAME}"

if [ ! -x "$(command -v snap)" ]; then
    echo_error "\"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'"
    exit 1
fi

# remove with snap
echo_info "sudo snap remove \"${APP_NAME}\""
sudo snap remove "${APP_NAME}"

# remove desktop shortcut
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${APP_NAME}\".desktop"
rm "$(xdg-user-dir DESKTOP)"/"${APP_NAME}".desktop
