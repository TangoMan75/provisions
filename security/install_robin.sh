#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## robin
##
## Robin: AI-Powered Dark Web OSINT Tool
##
## ```
## cd ~/.robin
## cp  .env.example .env
## cat .env
## sudo docker build -t robin .
## docker run --rm -v "$(pwd)/.env:/app/.env" --add-host=host.docker.internal:host-gateway -p 8501:8501 apurvsg/robin:latest ui --ui-port 8501 --ui-host 0.0.0.0
## ```
##
## @category security
## @link     https://github.com/apurvsinghgautam/robin

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

REPOSITORY=apurvsinghgautam/robin
DESTINATION="${HOME}/.robin"

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "mkdir -p \"${DESTINATION}\"\n"
mkdir -p "${DESTINATION}"

_echo_info "git clone https://github.com/${REPOSITORY} --depth=1 \"${DESTINATION}\"\n"
git clone https://github.com/${REPOSITORY} --depth=1 "${DESTINATION}"

