#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## cursor
##
## AI-powered code completion tool
##
## @category ide
## @link     https://cursor.com

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=cursor
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

# remove desktop link
_echo_info "rm \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)/${DESKTOP}"

