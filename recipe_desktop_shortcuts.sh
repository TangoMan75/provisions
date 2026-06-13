#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## recipe desktop shortcuts
##
## ```
## apt-cache pkgnames | grep gnome
## ls /usr/share/applications | grep gnome
## ```
##
## @license MIT
## @author  "Matthias Morin" <mat@tangoman.io>

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/tools/src/colors/colors.sh"

create_shortcut() {
    # create shortcut on desktop
    _echo_info "cp -p \"/usr/share/applications/$1\" \"$(xdg-user-dir DESKTOP)\"\n"
    cp -p "/usr/share/applications/$1" "$(xdg-user-dir DESKTOP)"
}

for shortcut in \
    org.gnome.Calculator.desktop \
    org.gnome.Calendar.desktop \
    org.gnome.clocks.desktop \
    org.gnome.Contacts.desktop \
    org.gnome.eog.desktop \
    org.gnome.Nautilus.desktop \
    org.gnome.seahorse.Application.desktop \
    org.gnome.SystemMonitor.desktop \
    org.gnome.TextEditor.desktop \
    org.gnome.Weather.desktop \
; do
    create_shortcut "${shortcut}"
done

