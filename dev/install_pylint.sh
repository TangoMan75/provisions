#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## pylint
##
## Python code static checker
##
## @category dev
## @link     https://github.com/pylint-dev/pylint
## @link     https://pypi.org/project/pylint

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=pylint

#--------------------------------------------------

if [ ! -x "$(command -v pipx)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pipx\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "pipx install ${APP_NAME}\n"
pipx install ${APP_NAME}

#--------------------------------------------------

_echo_info 'sync\n'
sync
