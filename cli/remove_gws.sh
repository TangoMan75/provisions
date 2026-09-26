#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove gws
##
## Google Workspace CLI — one command-line tool for Drive, Gmail, Calendar, Sheets, Docs, Chat, Admin, and more.
##
## @category cli
## @link     https://github.com/googleworkspace/cli
## @link     https://www.npmjs.com/package/@googleworkspace/cli
## @link     https://github.com/googleworkspace/cli?tab=readme-ov-file#manual-oauth-setup-google-cloud-console

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=gws
AUTHOR=googleworkspace
PACKAGE_NAME="@${AUTHOR}/cli"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_danger "Remove ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm uninstall -g ${PACKAGE_NAME}\n"
sudo npm uninstall -g "${PACKAGE_NAME}"

#--------------------------------------------------

_echo_warning "Remove config and data directories\n"

_echo_info "rm -rf \"${HOME}/.config/${APP_NAME}\"\n"
rm -rf "${HOME}/.config/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.cache/${APP_NAME}\"\n"
rm -rf "${HOME}/.cache/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.local/share/${APP_NAME}\"\n"
rm -rf "${HOME}/.local/share/${APP_NAME}"
