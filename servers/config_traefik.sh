#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config traefik
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

APP_NAME=traefik

_alert_warning "Config ${APP_NAME}"

#--------------------------------------------------

# config traefik
_echo_info "sudo cp -Rfv \"${CONFIG_DIR}/etc/traefik/ /etc/traefik/\"\n"
sudo cp -Rfv "${CONFIG_DIR}/etc/traefik/ /etc/traefik/"

