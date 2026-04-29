#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## freebuff
##
## The free coding agent
##
## ```
## freebuff "your prompt here"
## ```
##
## @category ai
## @link     https://freebuff.com
## @link     https://www.npmjs.com/package/freebuff
## @link     https://github.com/CodebuffAI/codebuff

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=freebuff

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "npm install -g ${APP_NAME}\n"
npm install -g ${APP_NAME}
