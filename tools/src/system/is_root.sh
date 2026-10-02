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

## Check user is root
is_root() {
    if [ "$(id | awk '{print $1}')" = 'uid=0(root)' ];then
        echo true
        return 0
    fi

    echo false
}

