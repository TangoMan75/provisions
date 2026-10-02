#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## task
##
## A task runner / simpler Make alternative written in Go
##
## @link     https://taskfile.dev
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=task
URL=https://dl.cloudsmith.io/public/task/task/setup.deb.sh

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ -x "$(command -v curl)" ]; then
    _echo_info "curl -1sLf '${URL}' | sudo -E bash\n"
    curl -1sLf "${URL}" | sudo -E bash

elif [ -x "$(command -v wget)" ]; then
    _echo_info "wget -qO- '${URL}' | sudo -E bash\n"
    wget -qO- "${URL}" | sudo -E bash

else
    _echo_danger 'error: Neither curl nor wget is available for downloading files.\n'
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes ${APP_NAME}\n"
sudo apt-get install --assume-yes "${APP_NAME}"
