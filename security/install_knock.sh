#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## knock
##
## find unadvertised subdomains
##
## @category security
## @link     https://github.com/guelfoweb/knock

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'Install knock'

if [ ! -x "$(command -v git)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires python3, try: 'sudo apt-get install -y python3'\n"
    exit 1
fi

if [ ! -x "$(command -v pip3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'\n"
    exit 1
fi

# Make sure that the python package manager and yaml libraries are installed
# _echo_info 'sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev\n'
# sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev

_echo_info 'git clone --depth 1 https://github.com/guelfoweb/knock ~/.knock\n'
git clone --depth 1 https://github.com/guelfoweb/knock ~/.knock

_echo_info 'pip3 install dnspython\n'
pip3 install dnspython

# cleaning
_echo_info 'rm -rf ~/.knock/.git\n'
rm -rf ~/.knock/.git

