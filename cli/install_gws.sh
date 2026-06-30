#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_gws
##
## Google Workspace CLI — one command-line tool for Drive, Gmail, Calendar, Sheets, Docs, Chat, Admin, and more.
##
## ```
## # Authenticate
## gws auth setup
## gws auth login
## ```
##
## @category cli
## @link     https://github.com/googleworkspace/cli
## @link     https://www.npmjs.com/package/@googleworkspace/cli
## @link     https://github.com/googleworkspace/cli?tab=readme-ov-file#manual-oauth-setup-google-cloud-console

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME="@googleworkspace/cli"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm, try: 'sudo apt-get install -y npm'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g "${PACKAGE_NAME}"

