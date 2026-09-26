#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fd
##
## A simple, fast and user-friendly alternative to find, used by Yazi for file searching
##
## @category   cli
## @link       https://github.com/sharkdp/fd

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# apt package name (Debian/Ubuntu ships fd as fd-find, exposing the fdfind binary)
APP_NAME=fd-find
# Yazi expects the binary to be named "fd"
FD_BINARY=fd
FDFIND_BINARY=fdfind
FD_SYMLINK="/usr/local/bin/${FD_BINARY}"

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get update\n"
sudo apt-get update

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# Yazi looks for "fd", but fd-find installs "fdfind"; expose a "fd" symlink
if [ -x "$(command -v "${FDFIND_BINARY}")" ] && [ ! -e "${FD_SYMLINK}" ]; then
    _echo_warning "Create \"${FD_SYMLINK}\" symlink to ${FDFIND_BINARY}\n"

    _echo_info "sudo ln -sf \"$(command -v "${FDFIND_BINARY}")\" \"${FD_SYMLINK}\"\n"
    sudo ln -sf "$(command -v "${FDFIND_BINARY}")" "${FD_SYMLINK}"
fi
