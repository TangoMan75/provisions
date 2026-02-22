#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install gemini-cli extensions
##
## @category ai
## @link     https://geminicli.com/docs/extensions
## @link     https://github.com/gemini-cli-extensions

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v gemini)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires gemini\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary 'Install Google Workspace gemini-cli extension'

#--------------------------------------------------

_echo_info 'gemini extensions install "https://github.com/gemini-cli-extensions/workspace --auto-update"\n'
gemini extensions install "https://github.com/gemini-cli-extensions/workspace --auto-update"

#--------------------------------------------------

_echo_info 'gemini extensions install https://github.com/AsyncFuncAI/ralph-wiggum-extension --auto-update\n'
gemini extensions install https://github.com/AsyncFuncAI/ralph-wiggum-extension --auto-update

