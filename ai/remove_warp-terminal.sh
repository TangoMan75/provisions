#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove warp-terminal
##
## Warp Terminal, a modern terminal with AI capabilities.
##
## @category ai
## @link     https://warp.dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=warp-terminal
DESKTOP=dev.warp.Warp.desktop

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

_echo_info "rm -rf \"${HOME}/.local/state/warp-terminal\"\n"
rm -rf "${HOME}/.local/state/warp-terminal"

_echo_info "rm -rf \"${HOME}/.config/warp-terminal\"\n"
rm -rf "${HOME}/.config/warp-terminal"

#--------------------------------------------------

# remove desktop shortcut
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/\"${DESKTOP}\"\n"
rm "$(xdg-user-dir DESKTOP)"/"${DESKTOP}"
