#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove virtualbox
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

alert_danger 'Remove virtualbox'

#--------------------------------------------------

echo_info "sudo apt purge -y \"virtualbox*\"\n"
sudo apt purge -y "virtualbox*"

#--------------------------------------------------

echo_info 'sudo apt -y autoremove\n'
sudo apt -y autoremove

#--------------------------------------------------

# remove configuration
echo_info "rm -rf \"${HOME}/.config/VirtualBox\"\n"
rm -rf "${HOME}/.config/VirtualBox"

#--------------------------------------------------

# remove desktop shortcut
echo_info "rm \"$(xdg-user-dir DESKTOP)/virtualbox.desktop\n"
rm "$(xdg-user-dir DESKTOP)/virtualbox.desktop"
