#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_rtk
##
## Install RTK CLI tool
##
## ```
## # install rtk
## rtk
## ```
##
## @category cli
## @link     https://github.com/rtk-ai/rtk

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=rtk
AUTHOR=rtk-ai
REPOSITORY=${AUTHOR}/${APP_NAME}

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -fsSL https://raw.githubusercontent.com/${REPOSITORY}/refs/heads/master/install.sh | sh\n"
    curl -fsSL https://raw.githubusercontent.com/${REPOSITORY}/refs/heads/master/install.sh | sh

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- https://raw.githubusercontent.com/${REPOSITORY}/refs/heads/master/install.sh | sh\n"
    wget -qO- https://raw.githubusercontent.com/${REPOSITORY}/refs/heads/master/install.sh | sh

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi