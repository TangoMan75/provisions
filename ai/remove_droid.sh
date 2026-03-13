#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove droid
##
## Droid is an AI coding assistant that lives in your terminal.
##
## @category ai
## @link     https://docs.factory.ai/cli/getting-started/quickstart

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=droid

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info 'rm -f ~/.local/bin/droid\n'
rm -f ~/.local/bin/droid

_echo_info 'rm -f /usr/local/bin/droid\n'
rm -f /usr/local/bin/droid

if command -v npm &> /dev/null; then
    _echo_info 'npm uninstall -g @factory/cli\n'
    npm uninstall -g @factory/cli 2>/dev/null || true

    _echo_info 'npm uninstall -g droid\n'
    npm uninstall -g droid 2>/dev/null || true
fi

_echo_info 'rm -rf ~/.config/droid\n'
rm -rf ~/.config/droid

_echo_info 'rm -rf ~/.factory\n'
rm -rf ~/.factory
