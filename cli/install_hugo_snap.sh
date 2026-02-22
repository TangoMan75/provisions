#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## hugo
##
## Hugo is a fast and flexible static site generator written in Go.
## It is designed to make website creation fun again.
##
## @category cli
## @link     https://gohugo.io

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=hugo

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v snap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires snap, try: 'sudo apt-get install -y snapd'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info "sudo snap install \"${APP_NAME}\"\n"
sudo snap install "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sync\n'
sync
