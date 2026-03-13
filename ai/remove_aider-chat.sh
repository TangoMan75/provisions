#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## aider-chat
##
## AI pair programming in your terminal
##
## @category ai
## @link     https://github.com/Aider-AI/aider
## @link     https://aider.chat

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=aider-chat

#--------------------------------------------------

_alert_primary "Remove ${APP_NAME}"

#--------------------------------------------------

REQUIRED_COMMANDS=(uv)
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v "${cmd}" &> /dev/null; then
        _echo_danger "error: \"$(basename "${0}")\" requires ${cmd}, try: 'sudo apt-get install -y ${cmd}'\n"
        exit 1
    fi
done

#--------------------------------------------------

_echo_info "uv tool uninstall \"${APP_NAME}\"\n"
uv tool uninstall "${APP_NAME}"

