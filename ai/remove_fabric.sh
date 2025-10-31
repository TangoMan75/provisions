#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove fabric
##
## @category ai
## @link     https://github.com/danielmiessler/fabric

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=fabric

#--------------------------------------------------

alert_primary "Remove ${APP_NAME}"

#--------------------------------------------------

echo_info "rm -rf \"${HOME}/.config/${APP_NAME}\"\n"
rm -rf "${HOME}/.config/${APP_NAME}"

#--------------------------------------------------

echo_info "rm -f \"${HOME}/.local/bin/${APP_NAME}\"\n"
rm -f "${HOME}/.local/bin/${APP_NAME}"

#--------------------------------------------------

echo_info "sudo rm -f \"/usr/bin/${APP_NAME}\"\n"
sudo rm -f "/usr/bin/${APP_NAME}"

