#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove ruff
##
## @category dev
## @link     https://github.com/astral-sh/ruff
## @link     https://docs.astral.sh/ruff/
## @link     https://pypi.org/project/ruff/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=ruff

#--------------------------------------------------

if [ ! -x "$(command -v pipx)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pipx\n"
    exit 1
fi

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "pipx uninstall ${APP_NAME}\n"
pipx uninstall "${APP_NAME}"
