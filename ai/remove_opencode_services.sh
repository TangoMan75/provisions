#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove opencode systemd services
##
## @category ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Remove opencode systemd services'

#--------------------------------------------------

_echo_info 'systemctl --user disable --now opencode-telegram.service opencode-serve.service\n'
systemctl --user disable --now opencode-telegram.service opencode-serve.service

#--------------------------------------------------

_echo_info "rm -f \"${HOME}/.config/systemd/user/opencode-serve.service\"\n"
rm -f "${HOME}/.config/systemd/user/opencode-serve.service"

_echo_info "rm -f \"${HOME}/.config/systemd/user/opencode-telegram.service\"\n"
rm -f "${HOME}/.config/systemd/user/opencode-telegram.service"

#--------------------------------------------------

_echo_info "systemctl --user daemon-reload\n"
systemctl --user daemon-reload
