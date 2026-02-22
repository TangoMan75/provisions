#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config_keyboard
##
## @category system

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ -f '/etc/default/keyboard' ]; then
    _echo_info "sudo sed -ie '/^XKBLAYOUT=/s/\".*\"/\"fr\"/' /etc/default/keyboard\n"
    sudo sed -ie '/^XKBLAYOUT=/s/".*"/"fr"/' /etc/default/keyboard

    # note:  /string1/s/string2/string3/ => replace string1string2 by string1string3
    # TLDR; `s/` doesn't have to be at the beginnig of a string
    _echo_info "sudo sed -ie '/^XKBOPTIONS=/s/\".*\"/\"shift:breaks_caps\"/' /etc/default/keyboard\n"
    sudo sed -ie '/^XKBOPTIONS=/s/".*"/"shift:breaks_caps"/' /etc/default/keyboard
fi

_echo_info 'udevadm trigger --subsystem-match=input --action=change\n'
udevadm trigger --subsystem-match=input --action=change

