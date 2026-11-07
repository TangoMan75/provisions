#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove tmog
##
## TMOG is a native system monitor and task manager for Linux, built with
## Qt 6 Widgets over a shared C++20 measuring core.
##
## @category system
## @link     https://tmog.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=tmog
PACKAGE_NAME=taskmanagerog
DESKTOP=com.tmog.taskmanager.desktop

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

_echo_info "sudo dpkg --purge \"${PACKAGE_NAME}\"\n"
sudo dpkg --purge "${PACKAGE_NAME}"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)"/"${DESKTOP}"
