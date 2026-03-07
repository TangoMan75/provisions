#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove fonts-powerline
##
## @category fonts
## @license  MIT

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Remove powerline fonts cache'

_echo_info 'apt-cache policy fonts-powerline\n'
apt-cache policy fonts-powerline

_echo_info 'sudo apt purge -y fonts-powerline\n'
sudo apt purge -y fonts-powerline

_echo_info 'rm ~/.local/share/fonts/PowerlineSymbols.otf\n'
rm ~/.local/share/fonts/PowerlineSymbols.otf

_echo_info 'fc-cache -vf\n'
fc-cache -vf

