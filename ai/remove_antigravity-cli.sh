#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove antigravity-cli
##
## Google Antigravity CLI (agy) - official command-line interface for interacting
## with the Antigravity agent harness. This script removes the binary and
## associated config directories.
##
## @category ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=antigravity-cli
BINARY=agy
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -f \"${DESTINATION}/${BINARY}\"\n"
rm -f "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "Remove config directories\n"

_echo_info "rm -rf \"${HOME}/.gemini/${APP_NAME}\"\n"
rm -rf "${HOME}/.gemini/${APP_NAME}"

#--------------------------------------------------

_echo_warning "TODO: Check your shell profile (~/.bashrc, ~/.zshrc) for PATH entries added by the antigravity installer\n"
