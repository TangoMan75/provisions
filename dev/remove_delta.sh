#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove delta
##
## A syntax-highlighting pager for git, diff, and grep output
##
## @category dev
## @link     https://github.com/dandavison/delta

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME="delta"
BINARY="${APP_NAME}"
DESTINATION="/usr/bin"

#--------------------------------------------------

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_warning "Remove ${BINARY} binary\n"

_echo_info "sudo rm -f \"${DESTINATION}/${BINARY}\"\n"
sudo rm -f "${DESTINATION}/${BINARY}"

#--------------------------------------------------

_echo_warning "Revert git config entries set by the install script\n"

_echo_info 'git config --global --unset core.pager\n'
git config --global --unset core.pager

_echo_info 'git config --global --unset interactive.diffFilter\n'
git config --global --unset interactive.diffFilter

_echo_info 'git config --global --unset delta.navigate\n'
git config --global --unset delta.navigate

_echo_info 'git config --global --unset delta.dark\n'
git config --global --unset delta.dark

_echo_info 'git config --global --unset merge.conflictStyle\n'
git config --global --unset merge.conflictStyle
