#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Laya
##
## Multilingual, non-autoregressive System 1 decision engine.
## Typed decisions (choice, score, noul) over any text in 100+ languages in a single forward pass, with a router that picks the right checkpoint per request. Requires Python 3.10 or newer. Installs the `laya` CLI.
##
## ```
## # start laya web server (GUI is not shipped with the pip package)
## laya-serve
##
## # http://localhost:8000/health
##
## curl -s localhost:8000/v1/systemone -H 'content-type: application/json' -d '{
##   "state": {"body": "We were billed twice. Please refund."},
##   "questions": {
##     "dept": {"type": "choice", "instructions": "Which team?",
##              "criteria": {"billing": "refunds", "other": "everything else"}}
##   }
## }'
## ```
##
## @category ai
## @link     https://github.com/NandhaKishorM/laya
## @link     https://pypi.org/project/laya/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=laya

#--------------------------------------------------

if [ ! -x "$(command -v pipx)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pipx\n"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires python3, try: 'sudo apt-get install -y python3 python3-venv'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info 'pipx install laya\n'
pipx install laya

_echo_info "pipx install 'laya[serve]' --force\n"
pipx install 'laya[serve]' --force
