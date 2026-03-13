#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## Disable Wayland to allow screen sharing
##
## @license  MIT
## @author   "Matthias Morin" <mat@tangoman.io>
## @category drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) _echo_success 'description:' 2 14; _echo_primary "$(basename "${0}"): Disable Wayland to allow screen sharing\n"
            _echo_success 'usage:' 2 14; _echo_primary "$(basename "${0}") -h (help)\n"
            exit 0;;
        \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done

_alert_primary 'Disable Wayland'

if [ "${XDG_SESSION_TYPE}" = 'wayland' ]; then
    # force the login screen to use Xorg
    _echo_info "sudo sed -i -E 's/^#?WaylandEnable=.+/WaylandEnable=false/' /etc/gdm3/custom.conf\n"
    sudo sed -i -E 's/^#?WaylandEnable=.+/WaylandEnable=false/' /etc/gdm3/custom.conf
    _echo_success 'Your system is set to use x11\n'
    _echo_warning 'You need to reboot your system for the change to take effect\n'

    exit 0
fi

_echo_danger "error: Wayland is already disabled : Your session type is \"${XDG_SESSION_TYPE}\"\n"

