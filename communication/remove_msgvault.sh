#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## msgvault
##
## Local-first, open-source archive for email, chat, meetings, calendars,
## and contacts. Keep your history on your own hardware, find messages and
## files, and connect the addresses and handles that belong to the same
## person. Use the browser, terminal, CLI, HTTP API, or an AI assistant
## through MCP.
##
## @category communication
## @link     https://msgvault.io
## @link     https://github.com/kenn-io/msgvault

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=msgvault
DESTINATION=/usr/local/bin

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo rm -f \"${DESTINATION}/${APP_NAME}\"\n"
sudo rm -f "${DESTINATION}/${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -rf \"${HOME}/.config/${APP_NAME}\"\n"
rm -rf "${HOME}/.config/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.cache/${APP_NAME}\"\n"
rm -rf "${HOME}/.cache/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.local/share/${APP_NAME}\"\n"
rm -rf "${HOME}/.local/share/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.local/state/${APP_NAME}\"\n"
rm -rf "${HOME}/.local/state/${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${APP_NAME}.desktop"
