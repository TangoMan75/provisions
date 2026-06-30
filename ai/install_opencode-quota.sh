#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## opencode-quota
##
## OpenCode quota management CLI tool
##
## @category ai
## @link     https://www.npmjs.com/package/@slkiser/opencode-quota
## @link     https://github.com/slkiser/opencode-quota

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v npx)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npx\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary 'Install slkiser/opencode-quota'

#--------------------------------------------------

_echo_info "npx @slkiser/opencode-quota init\n"
npx @slkiser/opencode-quota init
