#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## puppeteer
##
## JavaScript library providing a high-level API to control Chrome or Firefox
## over the DevTools Protocol or WebDriver BiDi. Runs headless by default.
##
## ```
## # example usage
## node -e "const p = require('puppeteer'); (async () => { const b = await p.launch(); await b.close(); })()"
## ```
##
## @category dev
## @link     https://pptr.dev
## @link     https://github.com/puppeteer/puppeteer
## @link     https://www.npmjs.com/package/puppeteer

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=puppeteer
PACKAGE_NAME="${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g "${PACKAGE_NAME}"

_echo_info "npx puppeteer browsers install\n"
npx puppeteer browsers install
