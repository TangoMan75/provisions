#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Github CLI
##
## gh --help
##
## @category dev
## @link     https://github.com/cli/cli/

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

BINARY_PATH=/usr/local/bin/gh
CONFIG_DIR=${HOME}/.config/gh

#--------------------------------------------------

_alert_danger "Remove GitHub CLI"

#--------------------------------------------------

# remove binary
if [ -f "${BINARY_PATH}" ]; then
    _echo_info "sudo rm -f \"${BINARY_PATH}\"\n"
    sudo rm -f "${BINARY_PATH}"
else
    _echo_warning "Binary \"${BINARY_PATH}\" not found\n"
fi

#--------------------------------------------------

# remove configuration directory
if [ -d "${CONFIG_DIR}" ]; then
    _echo_info "rm -rf \"${CONFIG_DIR}\"\n"
    rm -rf "${CONFIG_DIR}"
else
    _echo_warning "Configuration directory \"${CONFIG_DIR}\" not found\n"
fi

#--------------------------------------------------

_echo_info 'sync\n'
sync