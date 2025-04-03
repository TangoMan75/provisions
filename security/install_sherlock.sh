#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## sherlock
##
## Hunt down social media accounts by username across social networks
##
## ```
## cd ~/.sherlock/sherlock
## python3 sherlock.py --csv --print-all USERNAMES
## ```
##
## @category security
## @link     https://github.com/sherlock-project/sherlock

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install sherlock'

if [ ! -x "$(command -v git)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

if [ ! -x "$(command -v pip3)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'\n"
    exit 1
fi

echo_info 'mkdir -p ~/.sherlock\n'
mkdir -p ~/.sherlock

echo_info 'git clone --depth 1 https://github.com/sherlock-project/sherlock ~/.sherlock\n'
git clone --depth 1 https://github.com/sherlock-project/sherlock ~/.sherlock

echo_info 'rm -rf ~/.sherlock/.git\n'
rm -rf ~/.sherlock/.git

# echo_info 'sudo pip3 install --user --upgrade setuptools\n'
# sudo pip3 install --user --upgrade setuptools

echo_info 'pip3 install --user -r ~/.sherlock/requirements.txt\n'
pip3 install --user -r ~/.sherlock/requirements.txt