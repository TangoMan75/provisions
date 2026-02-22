#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## A short description
##
## ```
## # example usage
## template -f foobar
## ```
##
## @category template
## @link     https://github.com/TangoMan75/template
## @link     https://pypi.org/project/template

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template

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

# this is only useful when installing cli tools
_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync
