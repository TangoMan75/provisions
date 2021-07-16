#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
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
    echo_error "\"$(basename "${0}")\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

if [ ! -x "$(command -v python3)" ]; then
    echo_error "\"$(basename "${0}")\" requires python3, try: 'sudo apt-get install -y python3'"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev'
sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev

echo_info 'mkdir ~/.netfilterqueue'
mkdir ~/.netfilterqueue

echo_info 'git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue'
git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue

(
    echo_info 'cd ~/.netfilterqueue || exit 1'
    cd ~/.netfilterqueue || exit 1

    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'sudo python setup.py install'
    sudo python setup.py install
)
