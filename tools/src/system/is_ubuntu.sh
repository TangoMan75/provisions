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

## Check system is ubuntu
function is_ubuntu() {
    local RELEASE
    RELEASE="$(lsb_release -cs 2>/dev/null)"

    for CODENAME in edgy feisty gutsy hardy intrepid jaunty karmic lucid maverick natty oneiric precise quantal raring saucy trusty utopic vivid wily xenial yakkety zesty artful bionic cosmic disco eoan focal groovy hirsute impish jammy
    do
        if [ "${RELEASE}" = "${CODENAME}" ]; then
            echo true
            return 0
        fi
    done
    echo false
}
