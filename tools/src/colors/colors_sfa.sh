#!/bin/sh

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Symfony Colors
# *
# * A semantic set of colors for shell scripts inspired by Bootstrap and Symfony
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @link    https://github.com/TangoMan75/tools
# * @version 0.1.0-sfa
# */

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[104;37m'; ALERT_SECONDARY='\033[45;37m'; ALERT_SUCCESS='\033[42;30m'; ALERT_DANGER='\033[41;37m'; ALERT_WARNING='\033[43;30m'; ALERT_INFO='\033[44;37m'; ALERT_LIGHT='\033[47;90m'; ALERT_DARK='\033[40;37m';
}

echo_primary()   { printf "%b%b${EOL}" "${PRIMARY}"   "${*}"; }
echo_secondary() { printf "%b%b${EOL}" "${SECONDARY}" "${*}"; }
echo_success()   { printf "%b%b${EOL}" "${SUCCESS}"   "${*}"; }
echo_danger()    { printf "%b%b${EOL}" "${DANGER}"    "${*}"; }
echo_warning()   { printf "%b%b${EOL}" "${WARNING}"   "${*}"; }
echo_info()      { printf "%b%b${EOL}" "${INFO}"      "${*}"; }
echo_light()     { printf "%b%b${EOL}" "${LIGHT}"     "${*}"; }
echo_dark()      { printf "%b%b${EOL}" "${DARK}"      "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s ${DEFAULT}" "${SUCCESS}" "$2"; else printf "%b%b ${DEFAULT}" "${SUCCESS}" "${*}"; fi }
echo_error()     { printf "%berror: %b${EOL}" "${DANGER}"  "${*}"; }

alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_PRIMARY}"   ''  "${ALERT_PRIMARY}"   "${*}"            "${ALERT_PRIMARY}"   '' ; }
alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_SECONDARY}" ''  "${ALERT_SECONDARY}" "${*}"            "${ALERT_SECONDARY}" '' ; }
alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_SUCCESS}"   ''  "${ALERT_SUCCESS}"   "[OK] ${*}"       "${ALERT_SUCCESS}"   '' ; }
alert_danger()    { printf "${EOL}%b %-63s${EOL}%b %-63s${EOL}%b %-63s${EOL}\n" "${ALERT_DANGER}"    '!' "${ALERT_DANGER}"    "! [ERROR] ${*}" "${ALERT_DANGER}"    '!'; }
alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_WARNING}"   ''  "${ALERT_WARNING}"   "[WARNING] ${*}"  "${ALERT_WARNING}"   '' ; }
alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_INFO}"      ''  "${ALERT_INFO}"      "[INFO] ${*}"     "${ALERT_INFO}"      '' ; }
alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_LIGHT}"     ''  "${ALERT_LIGHT}"     "${*}"            "${ALERT_LIGHT}"     '' ; }
alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n"     "${ALERT_DARK}"      ''  "${ALERT_DARK}"      "${*}"            "${ALERT_DARK}"      '' ; }
