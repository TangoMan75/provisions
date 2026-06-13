#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove jetbrains-toolbox
##
## @category ide
## @link     https://www.jetbrains.com/toolbox-app

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Remove JetBrains Toolbox'

# remove desktop link
_echo_info "rm \"$(xdg-user-dir DESKTOP)\"/jetbrains-toolbox.desktop\n"
rm "$(xdg-user-dir DESKTOP)"/jetbrains-toolbox.desktop

# remove binary
_echo_info 'sudo rm -rf /usr/local/bin/jetbrains-toolbox\n'
sudo rm -rf /usr/local/bin/jetbrains-toolbox

_echo_info 'sudo rm -rf ~/.local/share/JetBrains/Toolbox\n'
sudo rm -rf ~/.local/share/JetBrains/Toolbox

