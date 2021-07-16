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
# * knock
# *
# * find unadvertised subdomains
# *
# * @category security
# * @link     https://github.com/guelfoweb/knock
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

echo_info 'git clone --depth 1 https://github.com/guelfoweb/knock ~/.knock'
git clone --depth 1 https://github.com/guelfoweb/knock ~/.knock

echo_info 'pip3 install dnspython'
pip3 install dnspython

# cleaning
echo_info 'rm -rf ~/.knock/.git'
rm -rf ~/.knock/.git

