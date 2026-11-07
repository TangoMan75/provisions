#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config tmux
##
## @category cli
## @link     https://github.com/tmux/tmux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

CONFIG_DIR="${CURDIR}/../config"

#--------------------------------------------------

_alert_secondary 'Config tmux'

#--------------------------------------------------

# check tmux installed
if [ ! -x "$(command -v tmux)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires tmux, try: 'sudo apt-get install -y tmux'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "cp -fv \"${CONFIG_DIR}/home/.tmux.conf\" ~\n"
cp -fv "${CONFIG_DIR}/home/.tmux.conf" ~

#--------------------------------------------------

_echo_warning 'Reload tmux configuration with "tmux source-file ~/.tmux.conf"\n'
