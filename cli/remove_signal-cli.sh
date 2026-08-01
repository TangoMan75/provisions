#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove signal-cli
##
## signal-cli is a commandline interface for the Signal messenger.
## This script removes the GraalVM native build binary and its
## associated runtime directories.
##
## @category cli
## @link     https://github.com/AsamK/signal-cli
## @link     https://github.com/AsamK/signal-cli/wiki
## @link     https://github.com/AsamK/signal-cli/wiki/Binary-distributions
## @link     https://github.com/AsamK/signal-cli#install-system-wide-on-linux--graalvm-native-build-

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=signal-cli
BINARY="${APP_NAME}"
DESTINATION=/usr/local/bin

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo rm -f \"${DESTINATION}/${BINARY}\"\n"
sudo rm -f "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "Remove config and data directories\n"

_echo_info "rm -rf \"${HOME}/.config/${APP_NAME}\"\n"
rm -rf "${HOME}/.config/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.local/share/${APP_NAME}\"\n"
rm -rf "${HOME}/.local/share/${APP_NAME}"
