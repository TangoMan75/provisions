#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * config apt repositories
# *
# * @category kali
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ "$(lsb_release -is 2>/dev/null)" = 'Kali' ]; then
    echo_info "sudo sh -c \"echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list\""
    sudo sh -c "echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list"

    echo_info 'sudo apt-get update'
    sudo apt-get update
else
    echo_error 'wrong system'
fi
