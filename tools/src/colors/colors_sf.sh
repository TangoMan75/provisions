#!/bin/sh

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Colors
##
## A semantic set of colors for shell scripts inspired by Bootstrap and Symfony
##
## @author  "Matthias Morin" <mat@tangoman.io>
## @link    https://github.com/TangoMan75/tools
## @version 0.1.0

#--------------------------------------------------
# Colors global variables
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[104;37m'; ALERT_SECONDARY='\033[45;37m'; ALERT_SUCCESS='\033[42;30m'; ALERT_DANGER='\033[41;37m'; ALERT_WARNING='\033[43;30m'; ALERT_INFO='\033[44;37m'; ALERT_LIGHT='\033[47;90m'; ALERT_DARK='\033[40;37m';
}

#--------------------------------------------------
# A semantic set of colors functions
#--------------------------------------------------

# Synopsys: echo_* [string] (indentation) (padding)

## Print primary (bright white text)
_echo_primary() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${PRIMARY}" "$3" "$1" "${DEFAULT}"
}

## Print secondary (bright blue text)
_echo_secondary() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${SECONDARY}" "$3" "$1" "${DEFAULT}"
}

## Print success (bright green text)
_echo_success() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${SUCCESS}" "$3" "$1" "${DEFAULT}"
}

## Print danger (red text)
_echo_danger() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${DANGER}" "$3" "$1" "${DEFAULT}"
}

## Print warning (orange text)
_echo_warning() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${WARNING}" "$3" "$1" "${DEFAULT}"
}

## Print info (bright purple text)
_echo_info() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${INFO}" "$3" "$1" "${DEFAULT}"
}

## Print light (black text over white background)
_echo_light() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${LIGHT}" "$3" "$1" "${DEFAULT}"
}

## Print dark (white text over black background)
_echo_dark() {
    if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi
    printf '%*b%b%-*b%b' "$2" '' "${DARK}" "$3" "$1" "${DEFAULT}"
}

# Synopsys: alert_* [string]

## Print primary alert (white text over bright blue background)
_alert_primary() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}" '' "${ALERT_PRIMARY}" "$1" "${ALERT_PRIMARY}" '';
}

## Print secondary alert (white text over bright purple background)
_alert_secondary() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "$1" "${ALERT_SECONDARY}" '';
}

## Print success alert (black text over bright green background)
_alert_success() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}" '' "${ALERT_SUCCESS}" "$1" "${ALERT_SUCCESS}" '';
}

## Print danger alert (white text over bright red background)
_alert_danger() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}" '' "${ALERT_DANGER}" "$1" "${ALERT_DANGER}" '';
}

## Print warning alert (black text over bright orange background)
_alert_warning() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}" '' "${ALERT_WARNING}" "$1" "${ALERT_WARNING}" '';
}

## Print info alert (white text over bright blue background)
_alert_info() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}" '' "${ALERT_INFO}" "$1" "${ALERT_INFO}" '';
}

## Print light alert (grey text over white background)
_alert_light() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_LIGHT}" '' "${ALERT_LIGHT}" "$1" "${ALERT_LIGHT}" '';
}

## Print dark alert (white text over black background)
_alert_dark() {
    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DARK}" '' "${ALERT_DARK}" "$1" "${ALERT_DARK}" '';
}
