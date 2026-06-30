#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## nfs-server
## nfs file sharing server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAMES='nfs-common nfs-kernel-server nfs-server'

_alert_primary "Install ${APP_NAMES}"

#--------------------------------------------------

for APP_NAME in ${APP_NAMES}; do
    _echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
    sudo apt-get install --assume-yes "${APP_NAME}"
done

#--------------------------------------------------

# starting nfs-kernel-server
_echo_info 'sudo service nfs-kernel-server start\n'
sudo service nfs-kernel-server start

