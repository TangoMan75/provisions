#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install droid
##
## Droid is an AI coding assistant that lives in your terminal.
##
## @category ai
## @link     https://factory.ai
## @link     https://docs.factory.ai/cli/getting-started/quickstart

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=droid
URL=https://app.factory.ai/cli

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL ${URL} | sh\n"
    curl -fsSL "${URL}" | sh

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- ${URL} | sh\n"
    wget -qO- "${URL}" | sh

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi
