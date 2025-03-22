#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## tor browser
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Remove torbrowser'

echo_info 'sudo apt-get remove --assume-yes torbrowser-launcher\n'
sudo apt-get remove --assume-yes torbrowser-launcher

# remove desktop shortcut
echo_info "rm \"$(xdg-user-dir DESKTOP)\"/torbrowser.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/torbrowser.desktop

