#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Colors Demo
##
## A demo to test colors
##
## colors: {30..37}
## high intensity foreground: {90..97}
## bold: 1
## underline: 4
## background: {40..47}
## high intensity background: {100..107}
##
## @author  "Matthias Morin" <mat@tangoman.io>
## @link    https://github.com/TangoMan75/tools

## Print color range table
function print_colors() {
    for foreground in {30..37} {90..97}; do
        for attr in 0 1 4; do
            for background in 0 {40..47} {100..107}; do
                if [ "${background}" -eq 0 ] && [ "${attr}" -eq 0 ]; then
                    echo -en "\033[${foreground}m" 
                    printf "%11s" "[${foreground}m "
                    echo -en "\033[0m"
                elif [ "${attr}" -eq 0 ]; then
                    echo -en "\033[${background};${foreground}m" 
                    printf "%11s" "[${background};${foreground}m "
                    echo -en "\033[0m"
                elif [ "${background}" -eq 0 ]; then
                    echo -en "\033[${attr};${foreground}m" 
                    printf "%11s" "[${attr};${foreground}m "
                    echo -en "\033[0m"
                else
                    echo -en "\033[$attr;${background};${foreground}m" 
                    printf "%11s" "[${attr};${background};${foreground}m "
                    echo -en "\033[0m"
                fi
            done
            echo
        done
    done
}

print_colors
