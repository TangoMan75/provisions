#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v luarocks)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires luarocks, try: 'sudo apt-get install -y luarocks'\n"
    exit 1
fi

#--------------------------------------------------

echo_info "sudo luarocks install ${APP_NAME}\n"
sudo luarocks install ${APP_NAME}

#--------------------------------------------------

echo_info 'sync\n'
sync

