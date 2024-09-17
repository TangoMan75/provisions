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
# * A semantic set of colors for shell scripts inspired by Bootstrap and Symfony (minified)
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @link    https://github.com/TangoMan75/tools
# * @version 0.1.0-sfc
# */

echo_primary()   { printf '\033[97m%b\033[0m\n'    "${*}"; }
echo_secondary() { printf '\033[94m%b\033[0m\n'    "${*}"; }
echo_success()   { printf '\033[32m%b\033[0m\n'    "${*}"; }
echo_danger()    { printf '\033[31m%b\033[0m\n'    "${*}"; }
echo_warning()   { printf '\033[33m%b\033[0m\n'    "${*}"; }
echo_info()      { printf '\033[95m%b\033[0m\n'    "${*}"; }
echo_light()     { printf '\033[47;90m%b\033[0m\n' "${*}"; }
echo_dark()      { printf '\033[40;37m%b\033[0m\n' "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s \033[0m" '\033[32m' "$2"; else printf "%b%b \033[0m" '\033[32m' "${*}"; fi }
echo_error()     { printf '%berror: %b\033[0m\n' '\033[31m' "${*}"; }

alert_primary()   { printf "\033[0m\n\033[104;37m%64s\033[0m\n\033[104;37m %-63s\033[0m\n\033[104;37m%64s\033[0m\n\n"  '' "${*}" ''; }
alert_secondary() { printf "\033[0m\n\033[45;37m%64s\033[0m\n\033[45;37m %-63s\033[0m\n\033[45;37m%64s\033[0m\n\n"     '' "${*}" ''; }
alert_success()   { printf "\033[0m\n\033[42;30m%64s\033[0m\n\033[42;30m %-63s\033[0m\n\033[42;30m%64s\033[0m\n\n"     '' "[OK] ${*}" ''; }
alert_danger()    { printf "\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\n" '!' "! [ERROR] ${*}" '!'; }
alert_warning()   { printf "\033[0m\n\033[43;30m%64s\033[0m\n\033[43;30m %-63s\033[0m\n\033[43;30m%64s\033[0m\n\n"     '' "[WARNING] ${*}" ''; }
alert_info()      { printf "\033[0m\n\033[44;37m%64s\033[0m\n\033[44;37m %-63s\033[0m\n\033[44;37m%64s\033[0m\n\n"     '' "[INFO] ${*}" ''; }
alert_light()     { printf "\033[0m\n\033[47;90m%64s\033[0m\n\033[47;90m %-63s\033[0m\n\033[47;90m%64s\033[0m\n\n"     '' "${*}" ''; }
alert_dark()      { printf "\033[0m\n\033[40;37m%64s\033[0m\n\033[40;37m %-63s\033[0m\n\033[40;37m%64s\033[0m\n\n"     '' "${*}" ''; }
