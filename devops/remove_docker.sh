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
# * remove docker
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get remove --assume-yes docker'
sudo apt-get remove --assume-yes docker

echo_info 'sudo apt-get remove --assume-yes docker-engine'
sudo apt-get remove --assume-yes docker-engine

echo_info 'sudo apt-get remove --assume-yes docker.io'
sudo apt-get remove --assume-yes docker.io

echo_info 'sudo apt-get remove --assume-yes docker-ce'
sudo apt-get remove --assume-yes docker-ce

echo_info 'sudo apt-get remove --assume-yes docker-ce-cli'
sudo apt-get remove --assume-yes docker-ce-cli

echo_info 'sudo apt-get remove --assume-yes containerd.io'
sudo apt-get remove --assume-yes containerd.io

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

