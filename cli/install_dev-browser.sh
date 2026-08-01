#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## dev-browser
##
## A CLI browser for developers - Use devtools in your terminal
##
## ```
## dev-browser install  # installs Playwright + Chromium
## dev-browser          # open a new browser tab
## ```
##
## @category dev
## @link     https://www.dobrowser.io
## @link     https://github.com/SawyerHood/dev-browser
## @link     https://www.npmjs.com/package/dev-browser

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME="dev-browser"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g ${PACKAGE_NAME}

#--------------------------------------------------

_alert_primary "Install Playwright + Chromium"

#--------------------------------------------------

_echo_info "dev-browser install\n"
dev-browser install