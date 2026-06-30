#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## freetube
##
## @category multimedia
## @link     https://freetubeapp.io/#download

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=freetube

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo dpkg --purge \"${APP_NAME}\"\n"
sudo dpkg --purge "${APP_NAME}"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${APP_NAME}\".desktop\n"
rm "$(xdg-user-dir DESKTOP)"/"${APP_NAME}".desktop

