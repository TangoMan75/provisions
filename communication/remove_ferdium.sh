#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Ferdium
##
## @category   communication
## @link       https://ferdium.org/download
## @link       https://github.com/ferdium/ferdium-app

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=ferdium

_alert_danger "Uninstall ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo dpkg --remove \"${APP_NAME}\"\n"
sudo dpkg --remove "${APP_NAME}"

#--------------------------------------------------

# remove shortcut on desktop for flatpak app
_echo_info "rm \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"

