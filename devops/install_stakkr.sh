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
# * stakkr
# *
# * @category devops
# * @link     https://docs.stakkr.org/en/latest/pages/installation.html
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes python3-pip'
sudo apt-get install --assume-yes python3-pip

echo_info 'sudo apt-get install --assume-yes python3-setuptools'
sudo apt-get install --assume-yes python3-setuptools

echo_info 'sudo apt-get install --assume-yes python3-virtualenv'
sudo apt-get install --assume-yes python3-virtualenv

echo_info 'sudo apt-get install --assume-yes python3-wheel'
sudo apt-get install --assume-yes python3-wheel

echo_info 'sudo python3 -m pip --no-cache-dir install stakkr'
sudo python3 -m pip --no-cache-dir install stakkr
