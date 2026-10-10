#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## opencode-router
##
## Slack + Telegram bridge and directory router for a running opencode server.
## Lets teams interact with workers from Slack or Telegram and keeps chat
## surfaces mapped to the correct workspace directory.
##
## ```bash
## opencode-router start
##
## opencode-router telegram add <token> --id default
## opencode-router telegram list
## ```
##
## @category ai
## @link     https://github.com/different-ai/openwork
## @link     https://www.npmjs.com/package/opencode-router

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=opencode-router

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${APP_NAME}\n"
sudo npm install -g ${APP_NAME}
