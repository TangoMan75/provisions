#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove gimp
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# --------------------------------------------------

APP_NAME=gimp
DESKTOP=gimp.desktop

alert_danger "Remove ${APP_NAME}"

# --------------------------------------------------

echo_info "sudo apt-get remove --assume-yes \"${APP_NAME}\"\n"
sudo apt-get remove --assume-yes "${APP_NAME}"

# --------------------------------------------------

# Remove desktop shortcut if it exists
echo_info "rm -f \"$(xdg-user-dir DESKTOP)/${DESKTOP}\"\n"
rm -f "$(xdg-user-dir DESKTOP)/${DESKTOP}"
