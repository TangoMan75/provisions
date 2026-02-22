#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## nautilus-actions
## add custom actions to file manager context menus
##
## @category nautilus
## @link     http://www.nautilus-actions.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

# check system uses gnome
if [ "${XDG_CURRENT_DESKTOP}" != 'ubuntu:GNOME' ]; then
    RELEASE="$(lsb_release -cs 2>/dev/null)"
    _echo_danger "error: ${RELEASE} not supported\n"

    exit 1
fi

_echo_info 'sudo apt-get install --assume-yes nautilus-actions\n'
sudo apt-get install --assume-yes nautilus-actions

