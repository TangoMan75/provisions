#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove opencode-telegram-bot
##
## @category ai
## @link     https://github.com/grinev/opencode-telegram-bot
## @link     https://www.npmjs.com/package/@grinev/opencode-telegram-bot

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=opencode-telegram-bot
AUTHOR=grinev
PACKAGE_NAME="@${AUTHOR}/${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_danger "Remove ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm uninstall -g ${PACKAGE_NAME}\n"
sudo npm uninstall -g ${PACKAGE_NAME}
