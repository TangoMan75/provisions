#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## playwright
##
## Fast and reliable end-to-end testing for modern web apps.
## Playwright enables reliable web automation for testing, scripting, and AI agents
## with one API to drive Chromium, Firefox, and WebKit.
##
## ```
## # example usage
## playwright-cli open https://example.com
## playwright-cli --help
## ```
##
## @category dev
## @link     https://playwright.dev
## @link     https://github.com/microsoft/playwright
## @link     https://www.npmjs.com/package/@playwright/cli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

AUTHOR=playwright
PACKAGE_NAME="@${AUTHOR}/cli"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}@latest\n"
sudo npm install -g "${PACKAGE_NAME}@latest"

_echo_info "playwright-cli install --skills\n"
playwright-cli install --skills
