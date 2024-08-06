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
# * ansible
# *
# * @category devops
# * @link     https://docs.ansible.com
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes software-properties-common'
sudo apt-get install --assume-yes software-properties-common

echo_info 'sudo add-apt-repository --yes ppa:ansible/ansible'
sudo add-apt-repository --yes ppa:ansible/ansible

echo_info 'sudo apt-get install --assume-yes ansible'
sudo apt-get install --assume-yes ansible
