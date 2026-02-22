#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## luacheck
## Lua code linter
##
## @link     https://github.com/mpeterv/luacheck
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=luacheck

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v luarocks)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires luarocks, try: 'sudo apt-get install -y luarocks'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo luarocks install ${APP_NAME}\n"
sudo luarocks install ${APP_NAME}

#--------------------------------------------------

_echo_info 'sync\n'
sync

