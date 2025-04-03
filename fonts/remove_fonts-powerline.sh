#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
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

alert_primary 'Remove powerline fonts cache'

echo_info 'apt-cache policy fonts-powerline\n'
apt-cache policy fonts-powerline

echo_info 'sudo apt purge -y fonts-powerline\n'
sudo apt purge -y fonts-powerline

echo_info 'rm ~/.local/share/fonts/PowerlineSymbols.otf\n'
rm ~/.local/share/fonts/PowerlineSymbols.otf

echo_info 'fc-cache -vf\n'
fc-cache -vf

