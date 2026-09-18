#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove uv
##
## uv is an extremely fast Python package installer and resolver, written in Rust.
##
## @category dev
## @link     https://github.com/astral-sh/uv

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=uv

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info 'rm -f ~/.local/bin/uv\n'
rm -f ~/.local/bin/uv

_echo_info 'rm -f ~/.local/bin/uvx\n'
rm -f ~/.local/bin/uvx

_echo_info 'rm -rf ~/.config/uv\n'
rm -rf ~/.config/uv

