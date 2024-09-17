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
# * TangoMan Colors
# *
# * A semantic set of colors for shell scripts inspired by Bootstrap and Symfony
# *
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @link    https://github.com/TangoMan75/tools
# * @version 0.1.0-d
# */

echo_primary()   { printf '%b%b\033[0m' '\033[97m'    "${*}"; }
echo_secondary() { printf '%b%b\033[0m' '\033[94m'    "${*}"; }
echo_success()   { printf '%b%b\033[0m' '\033[32m'    "${*}"; }
echo_danger()    { printf '%b%b\033[0m' '\033[31m'    "${*}"; }
echo_warning()   { printf '%b%b\033[0m' '\033[33m'    "${*}"; }
echo_info()      { printf '%b%b\033[0m' '\033[95m'    "${*}"; }
echo_light()     { printf '%b%b\033[0m' '\033[47;90m' "${*}"; }
echo_dark()      { printf '%b%b\033[0m' '\033[40;37m' "${*}"; }

echo_label()     { if [ $# -eq 2 ]; then printf "%b%-${1}s \033[0m" '\033[32m' "$2"; else printf "%b%b \033[0m" '\033[32m' "${*}"; fi }
echo_error()     { printf '%berror: %b\033[0m' '\033[31m' "${*}"; }

alert_primary()   { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;104;97m' '' '\033[1;104;97m' "${*}" '\033[1;104;97m' ''; }
alert_secondary() { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;45;97m'  '' '\033[1;45;97m'  "${*}" '\033[1;45;97m'  ''; }
alert_success()   { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;42;97m'  '' '\033[1;42;97m'  "${*}" '\033[1;42;97m'  ''; }
alert_danger()    { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;41;97m'  '' '\033[1;41;97m'  "${*}" '\033[1;41;97m'  ''; }
alert_warning()   { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;43;97m'  '' '\033[1;43;97m'  "${*}" '\033[1;43;97m'  ''; }
alert_info()      { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;44;97m'  '' '\033[1;44;97m'  "${*}" '\033[1;44;97m'  ''; }
alert_light()     { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;47;90m'  '' '\033[1;47;90m'  "${*}" '\033[1;47;90m'  ''; }
alert_dark()      { printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;40;37m'  '' '\033[1;40;37m'  "${*}" '\033[1;40;37m'  ''; }
