#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove nfs file sharing server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=nfs-kernel-server
APP_NAME_2=nfs-common

alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# stopping nfs-kernel-server
echo_info "sudo service \"${APP_NAME}\" stop\n"
sudo service "${APP_NAME}" stop

#--------------------------------------------------

echo_info "sudo dpkg --purge \"${APP_NAME}\"\n"
sudo dpkg --purge "${APP_NAME}"

echo_info "sudo dpkg --purge \"${APP_NAME_2}\"\n"
sudo dpkg --purge "${APP_NAME_2}"

