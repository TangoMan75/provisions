#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove opencode-serve systemd services
##
## @category ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Remove opencode systemd service'

#--------------------------------------------------

if command -v opencode &> /dev/null; then
    _echo_info 'opencode service stop 2>/dev/null || true\n'
    opencode service stop 2>/dev/null || true
fi

#--------------------------------------------------

_echo_info "rm -f \"${HOME}/.config/systemd/user/opencode-serve.service\"\n"
rm -f "${HOME}/.config/systemd/user/opencode-serve.service"

#--------------------------------------------------

_echo_info "systemctl --user daemon-reload\n"
systemctl --user daemon-reload
