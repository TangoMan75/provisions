#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove zsh
##
## @category system
## @license  MIT

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_danger 'Remove zsh'

# restore default shell
echo_info "chsh -s \"$(command -v bash)\"\n"
chsh -s "$(command -v bash)"

# uninstall zsh
echo_info 'sudo apt-get purge -y zsh zsh-common\n'
sudo apt-get purge -y zsh zsh-common

# cleaning
echo_info 'sudo apt -y autoremove\n'
sudo apt -y autoremove

