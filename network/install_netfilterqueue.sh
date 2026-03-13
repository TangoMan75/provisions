#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## netfilterqueue
##
## @category security

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v git)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires python3, try: 'sudo apt-get install -y python3'\n"
    exit 1
fi

_echo_info 'sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev\n'
sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev

_echo_info 'mkdir -p ~/.netfilterqueue\n'
mkdir -p ~/.netfilterqueue

_echo_info 'git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue\n'
git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue

(
    _echo_info 'cd ~/.netfilterqueue || exit 1\n'
    cd ~/.netfilterqueue || exit 1

    _echo_info 'rm -rf .git\n'
    rm -rf .git

    _echo_info 'sudo python setup.py install\n'
    sudo python setup.py install
)
