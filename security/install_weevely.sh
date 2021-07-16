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
# * weevely
# *
# * php web shell
# *
# * ```bash
# * weevely generate password123! /root/shell.php
# * weevely http://target-url.com/uploads/shell.php
# * ```
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

if [ ! -x "$(command -v pip3)" ]; then
    echo_error "\"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'"
    exit 1
fi

# Make sure that the python package manager and yaml libraries are installed
# echo_info 'sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev'
# sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev

# clone project
echo_info 'git clone --depth 1 https://github.com/epinna/weevely3.git ~/.weevely3'
git clone --depth 1 https://github.com/epinna/weevely3.git ~/.weevely3

# Install requirements from within the .weevely3 folder
(
    echo_info 'cd ~/.weevely3 || exit 1'
    cd ~/.weevely3 || exit 1

    # cleaning git cache
    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'sudo pip3 install -r requirements.txt --upgrade'
    sudo pip3 install -r requirements.txt --upgrade
)

