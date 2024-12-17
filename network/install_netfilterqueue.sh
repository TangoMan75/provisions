#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * netfilterqueue
# *
# * @category security
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v git)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'\n"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires python3, try: 'sudo apt-get install -y python3'\n"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev\n'
sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev

echo_info 'mkdir -p ~/.netfilterqueue\n'
mkdir -p ~/.netfilterqueue

echo_info 'git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue\n'
git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue

(
    echo_info 'cd ~/.netfilterqueue || exit 1\n'
    cd ~/.netfilterqueue || exit 1

    echo_info 'rm -rf .git\n'
    rm -rf .git

    echo_info 'sudo python setup.py install\n'
    sudo python setup.py install
)
