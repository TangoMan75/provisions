#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_zeroclaw
##
## Install ZeroClaw - Fast, small, autonomous AI assistant infrastructure
##
## ```
## # config can be found here
## ~/.zeroclaw
##
## # biniary can be found here
## ~/.cargo/bin/zeroclaw
##
## # start onboarding
## zeroclaw onboard --interactive
## ```
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zeroclaw
DESTINATION="${HOME}/.local/bin/${APP_NAME}"
VERSION=fix

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "cp \"./${APP_NAME}-${VERSION}\" \"${DESTINATION}\"\n"
cp "./${APP_NAME}-${VERSION}" "${DESTINATION}"

