#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * Disable Wayland to allow screen sharing
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) echo_success 'description:' 2 14; echo_primary "$(basename "${0}"): Disable Wayland to allow screen sharing\n"
            echo_success 'usage:' 2 14; echo_primary "$(basename "${0}") -h (help)\n"
            exit 0;;
        \?) echo_danger "error: invalid option \"${OPTARG}\"\n"
            exit 1;;
    esac
done

alert_primary 'Disable Wayland'

if [ "${XDG_SESSION_TYPE}" = 'wayland' ]; then
    # force the login screen to use Xorg
    echo_info "sudo sed -i -E 's/^#?WaylandEnable=.+/WaylandEnable=false/' /etc/gdm3/custom.conf\n"
    sudo sed -i -E 's/^#?WaylandEnable=.+/WaylandEnable=false/' /etc/gdm3/custom.conf
    echo_success 'Your system is set to use x11\n'
    echo_warning 'You need to reboot your system for the change to take effect\n'

    exit 0
fi

echo_danger "error: Wayland is already disabled : Your session type is \"${XDG_SESSION_TYPE}\"\n"

