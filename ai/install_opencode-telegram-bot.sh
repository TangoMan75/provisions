#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## opencode-telegram-bot
##
## OpenCode Telegram Bot is a secure Telegram client for OpenCode CLI that
## runs on your local machine. Run AI coding tasks, monitor progress, switch
## models, and manage sessions from your phone.
##
## ```bash
## opencode-telegram config
## ```
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

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g ${PACKAGE_NAME}

#--------------------------------------------------

_echo_warning 'Force opencode-telegram-bot to use ipv4\n'

_echo_info "sed -i 's/# TELEGRAM_FORCE_IPV4=false/TELEGRAM_FORCE_IPV4=true/' ~/.config/opencode-telegram-bot/.env\n"
sed -i 's/# TELEGRAM_FORCE_IPV4=false/TELEGRAM_FORCE_IPV4=true/' ~/.config/opencode-telegram-bot/.env
