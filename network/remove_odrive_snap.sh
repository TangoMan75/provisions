#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## odrive
##
## A GUI client for Google Drive
##
## @category network
## @link     https://github.com/liberodark/ODrive

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=odrive
DESKTOP=odrive_odrive.desktop

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap to install, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo snap remove \"${APP_NAME}\"\n"
sudo snap remove "${APP_NAME}"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"

