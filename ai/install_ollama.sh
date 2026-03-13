#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install ollama
##
## @category ai
## @link     https://ollama.com/download/linux

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install ollama'

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://ollama.com/install.sh | sh\n"
    curl -fsSL https://ollama.com/install.sh | sh

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -q https://ollama.com/install.sh | sh\n"
    wget -q https://ollama.com/install.sh | sh

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
