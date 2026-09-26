#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## n8n
##
## Install n8n workflow automation tool
##
## @category productivity
## @link     https://github.com/n8n-io/n8n
## @link     https://www.npmjs.com/package/n8n

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME=n8n

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install ${PACKAGE_NAME}"

#--------------------------------------------------

_echo_info "sudo npm install -g ${PACKAGE_NAME}\n"
sudo npm install -g ${PACKAGE_NAME}
