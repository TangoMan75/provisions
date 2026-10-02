#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Bash Tools
##
## A set of tools for shell scripts
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

## Check app installed
function is_installed() {

    if [ -x "$(command -v "$1")" ]; then
        echo true

        return 0
    fi

    # maybe it's a debian package
    if dpkg -s "$1" 2>/dev/null | grep -q 'Status: install ok installed'; then
        echo true

        return 0
    fi

    # or maybe it's a linuxbrew package
    if [ -x /home/linuxbrew/.linuxbrew/bin/"$1" ]; then
        echo true

        return 0
    fi

    echo false
}
