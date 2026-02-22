#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install_copilot-cli
##
## Install GitHub Copilot CLI - AI-powered coding assistant in your terminal
##
## ```
## # example usage
## ./install_copilot-cli.sh
## ```
##
## @category ai
## @link     https://github.com/github/copilot-cli
## @link     https://www.npmjs.com/package/@github/copilot

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PACKAGE_NAME="@github/copilot"

#--------------------------------------------------

if [ ! -x "$(command -v npm)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires npm, try: 'sudo apt-get install -y npm'\n"
    exit 1
fi

#--------------------------------------------------

_alert_primary "Install GitHub Copilot CLI"

#--------------------------------------------------

_echo_info "npm install -g ${PACKAGE_NAME}\n"
npm install -g ${PACKAGE_NAME}

#--------------------------------------------------

_echo_warning 'Update system\n'

_echo_info 'sync\n'
sync