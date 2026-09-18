#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## playwright-cli
##
## Playwright is a framework for Web Testing and Automation.
## It enables reliable end-to-end testing for modern web apps.
##
## First Use:
## ```
## playwright install
## playwright install-deps
## ```
##
## @category cli
## @link     https://playwright.dev
## @link     https://www.npmjs.com/package/playwright

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME=playwright

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

_echo_info 'playwright --version\n'
playwright --version
