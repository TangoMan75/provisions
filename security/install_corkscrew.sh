#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## corkscrew
##
## Get ssh through firewall and proxies, with http tunneling
##
## ```shell
## $ ssh -p 22 -o 'ProxyCommand corckscrew -p 192.168.1.1 8118 %h %p' -D 8080 user@remote.dev
## ```
##
## @category security
## @link     https://github.com/bryanpkc/corkscrew

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=corkscrew

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

