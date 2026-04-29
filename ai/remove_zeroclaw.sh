#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove zeroclaw
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=zeroclaw

#--------------------------------------------------

_alert_primary "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Remove binary\n'

if [ -x "$(command -v cargo)" ]; then
    _echo_info "cargo uninstall \"${APP_NAME}\"\n"
    cargo uninstall "${APP_NAME}"
fi

_echo_info "rm -f \"${HOME}/.cargo/bin/${APP_NAME}\"\n"
rm -f "${HOME}/.cargo/bin/${APP_NAME}"

#--------------------------------------------------

_echo_info "rm \"${HOME}/.local/bin/${APP_NAME}\"\n"
rm "${HOME}/.local/bin/${APP_NAME}"

#--------------------------------------------------

_echo_warning 'Remove configuration\n'

_echo_info "rm \"${HOME}/.${APP_NAME}\"\n"
rm "${HOME}/.${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.${APP_NAME}\"\n"
rm -rf "${HOME}/.${APP_NAME}"

