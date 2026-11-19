#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove fd
##
## @category   cli
## @link       https://github.com/sharkdp/fd

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=fd-find
FD_SYMLINK="/usr/local/bin/fd"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove -y \"${APP_NAME}\"\n"
sudo apt-get remove -y "${APP_NAME}"

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

#--------------------------------------------------

# Remove the "fd" symlink that pointed to fdfind
if [ -L "${FD_SYMLINK}" ]; then
    _echo_warning "Remove \"${FD_SYMLINK}\" symlink\n"

    _echo_info "sudo rm -f \"${FD_SYMLINK}\"\n"
    sudo rm -f "${FD_SYMLINK}"
fi
