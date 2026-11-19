#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove zeroclaw
##
## @category ai
## @link     https://github.com/zeroclaw-labs/zeroclaw
## @link     https://zeroclawlabs.ai

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

function remove_zero() {
    _alert_primary "Remove $1"

    #--------------------------------------------------

    _echo_warning 'Remove binary\n'

    if [ -x "$(command -v cargo)" ]; then
        _echo_info "cargo uninstall \"$1\"\n"
        cargo uninstall "$1"
    fi

    _echo_info "rm -f \"${HOME}/.cargo/bin/$1\"\n"
    rm -f "${HOME}/.cargo/bin/$1"

    #--------------------------------------------------

    _echo_info "rm \"${HOME}/.local/bin/$1\"\n"
    rm "${HOME}/.local/bin/$1"

    #--------------------------------------------------

    _echo_warning 'Remove configuration\n'

    _echo_info "rm \"${HOME}/.$1\"\n"
    rm "${HOME}/.$1"

    _echo_info "rm -rf \"${HOME}/.$1\"\n"
    rm -rf "${HOME}/.$1"
}

#--------------------------------------------------

remove_zero zeroclaw
remove_zero zerocode
