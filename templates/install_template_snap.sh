#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## A short description
##
## ```
## # example usage
## template -f foobar
## ```
##
## @category template
## @link     https://github.com/TangoMan75/provisions

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template
DESKTOP="${APP_NAME}".desktop

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snap'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo snap install \"${APP_NAME}\"\n"
sudo snap install "${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Create shortcut on desktop for snap app\n'

_echo_info "cp -p \"/var/lib/snapd/desktop/applications/${DESKTOP}\" \"$(xdg-user-dir DESKTOP)\"\n"
cp -p "/var/lib/snapd/desktop/applications/${DESKTOP}" "$(xdg-user-dir DESKTOP)"

