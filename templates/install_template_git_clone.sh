#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## template
##
## A short description
##
## ```
## # example usage
## template -f foobar
## ```
##
## @category template
## @link     https://github.com/TangoMan75/provisions

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=template
AUTHOR=TangoMan75
REPOSITORY=${AUTHOR}/${APP_NAME}
DESTINATION="${HOME}/.local/share/${APP_NAME}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

if [ ! -x "$(command -v git)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

#--------------------------------------------------

# clone project
_echo_info "git clone --depth 1 \"https://github.com/${REPOSITORY}\" \"${DESTINATION}\"\n"
git clone --depth 1 "https://github.com/${REPOSITORY}" "${DESTINATION}"
