#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove claude-code
##
## @category ai
## @link     https://www.claude.com
## @link     https://www.npmjs.com/package/@anthropic-ai/claude-code

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=claude-code
AUTHOR=anthropic-ai
PACKAGE_NAME="@${AUTHOR}/${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Remove ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm uninstall -g ${PACKAGE_NAME}"
sudo npm uninstall -g ${PACKAGE_NAME}

