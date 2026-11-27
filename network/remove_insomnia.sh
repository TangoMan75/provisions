#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## insomnia
##
## @category network
## @link     https://insomnia.rest

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=insomnia

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(dpkg)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_info "sudo dpkg --purge \"${APP_NAME}\"\n"
sudo dpkg --purge "${APP_NAME}"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${APP_NAME}\".desktop\n"
rm "$(xdg-user-dir DESKTOP)"/"${APP_NAME}".desktop
