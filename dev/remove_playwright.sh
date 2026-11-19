#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove playwright
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

_alert_danger "Remove ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm uninstall -g ${PACKAGE_NAME}\n"
sudo npm uninstall -g "${PACKAGE_NAME}"
