#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## bruno
##
## lightweight REST client and API testing tool
##
## @category network
## @link     https://www.usebruno.com
## @link     https://github.com/usebruno/bruno
## @link     https://marketplace.visualstudio.com/items?itemName=bruno-api-client.bruno

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=bruno
DESKTOP=${APP_NAME}.desktop

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

# Check for required commands
REQUIRED_COMMANDS=(apt-get)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

_echo_info "sudo rm /etc/apt/sources.list.d/${APP_NAME}.list\n"
sudo rm "/etc/apt/sources.list.d/${APP_NAME}.list"

_echo_info "sudo rm /etc/apt/keyrings/${APP_NAME}.gpg\n"
sudo rm "/etc/apt/keyrings/${APP_NAME}.gpg"

_echo_info 'sudo apt-get update\n'
sudo apt-get update

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)"/"${DESKTOP}"
