#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove wacli
##
## wacli is a scriptable WhatsApp client built on whatsmeow. It pairs
## as a linked WhatsApp Web device via QR, mirrors your messages into
## a local SQLite store with FTS5 search, and exposes offline search,
## sending, replies, contact/chat/group management and history
## backfill from the command line.
##
## This script removes the wacli binary and its local data directories
## (legacy ~/.wacli and XDG ~/.local/state/wacli). Unlinking the device
## from the WhatsApp mobile app is left to the user (WhatsApp > Linked
## Devices).
##
## @category cli
## @link     https://github.com/openclaw/wacli
## @link     https://wacli.sh

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=wacli
BINARY="${APP_NAME}"
DESTINATION="${HOME}/.local/bin"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "rm -f \"${DESTINATION}/${BINARY}\"\n"
rm -f "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "Remove wacli data directories\n"

# wacli defaults:
#   Linux:  ~/.local/state/wacli  (XDG state home)
#   Other:  ~/.wacli              (legacy / macOS / Windows)
# Both paths may coexist on Linux; clean them up to fully uninstall.
_echo_info "rm -rf \"${HOME}/.local/state/${APP_NAME}\"\n"
rm -rf "${HOME}/.local/state/${APP_NAME}"

_echo_info "rm -rf \"${HOME}/.${APP_NAME}\"\n"
rm -rf "${HOME}/.${APP_NAME}"

#--------------------------------------------------

_echo_warning "Unlink device from WhatsApp\n"
_echo_info 'Open WhatsApp on your phone, then: Settings > Linked Devices > select this device > Log out.\n'
