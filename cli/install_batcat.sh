#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## batcat
##
## A modern, feature-rich replacement for the standard Linux `cat` command
## enhancing file viewing with features like syntax highlighting,
## Git integration, and automatic paging.
##
## On modern versions of Ubuntu and Debian, the executable for the `bat`
## utility is often installed as `batcat` to avoid a name conflict with
## the existing `bacula-console-qt` package.
##
## @category cli

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=batcat

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get install --assume-yes \"${APP_NAME}\"\n"
sudo apt-get install --assume-yes "${APP_NAME}"

#--------------------------------------------------

# create a symlink in ~/.local/bin/bat to have a working bat alias in the terminal
_echo_info 'ln -s /usr/bin/batcat ~/.local/bin/bat\n'
ln -s /usr/bin/batcat ~/.local/bin/bat

