#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config apt repositories
##
## @category kali

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ "$(lsb_release -is 2>/dev/null)" = 'Kali' ]; then
    _echo_info "sudo sh -c \"echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list\"\n"
    sudo sh -c "echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list"

    _echo_info 'sudo apt-get update\n'
    sudo apt-get update
else
    _echo_danger 'error: wrong system'
fi
