#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove opencode
##
## @category ai
## @link     https://github.com/anomalyco/opencode

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=openwork

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo npm uninstall -g ${APP_NAME}\n"
sudo npm uninstall -g ${APP_NAME}

#--------------------------------------------------

_echo_info "rm -rf \"${HOME}/.cache/openwork\"\n"
rm -rf "${HOME}/.cache/openwork"

_echo_info "rm -rf \"${HOME}/.local/share/openwork\"\n"
rm -rf "${HOME}/.local/share/openwork"

_echo_info "rm -rf \"${HOME}/.local/state/openwork\"\n"
rm -rf "${HOME}/.local/state/openwork"

_echo_info "rm -rf \"${HOME}/.openwork\"\n"
rm -rf "${HOME}/.openwork"

