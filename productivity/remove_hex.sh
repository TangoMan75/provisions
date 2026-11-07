#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Remove Hex
##
## @category productivity
## @link     https://github.com/anomalyco/hex
## @link     https://anoma.ly/hex

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=hex
DESKTOP=anomaly.hex.desktop

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
for DESKTOP_FILE in "${DESKTOP}" "${APP_NAME}.desktop"; do
    if [ -f "$(xdg-user-dir DESKTOP)/${DESKTOP_FILE}" ]; then
        _echo_info "rm \"$(xdg-user-dir DESKTOP)/${DESKTOP_FILE}\"\n"
        rm "$(xdg-user-dir DESKTOP)/${DESKTOP_FILE}"
    fi
done

#--------------------------------------------------

_echo_warning "Logs and settings remain in \"${HOME}/.local/share/${APP_NAME}\"\n"
