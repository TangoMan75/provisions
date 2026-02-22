#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove clawdbot
##
## @category ai
## @link     https://www.npmjs.com/package/clawdbot
## @link     https://www.npmjs.com/package/moltbot
## @link     https://www.npmjs.com/package/openclaw
## @link     https://clawdbot.ai
## @link     https://molt.bot
## @link     https://openclaw.ai
## @link     https://github.com/clawdbot/clawdbot
## @link     https://github.com/moltbot/moltbot
## @link     https://github.com/openclaw/openclaw
## @link     https://clawdhub.com/skills
## @link     https://clawhub.ai/skills

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Remove Clawdbot / Moltbot / Openclaw"

#--------------------------------------------------

_echo_info 'npm uninstall -g clawdbot\n'
npm uninstall -g clawdbot

#--------------------------------------------------

_echo_info 'npm uninstall -g moltbot\n'
npm uninstall -g moltbot

#--------------------------------------------------

_echo_info 'npm uninstall -g openclaw\n'
npm uninstall -g openclaw

