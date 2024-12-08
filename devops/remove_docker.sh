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
# * remove docker
# *
# * @category devops
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_danger 'Remove docker'

echo_info 'sudo apt-get remove --assume-yes docker\n'
sudo apt-get remove --assume-yes docker

echo_info 'sudo apt-get remove --assume-yes docker-engine\n'
sudo apt-get remove --assume-yes docker-engine

echo_info 'sudo apt-get remove --assume-yes docker.io\n'
sudo apt-get remove --assume-yes docker.io

echo_info 'sudo apt-get remove --assume-yes docker-ce\n'
sudo apt-get remove --assume-yes docker-ce

echo_info 'sudo apt-get remove --assume-yes docker-ce-cli\n'
sudo apt-get remove --assume-yes docker-ce-cli

echo_info 'sudo apt-get remove --assume-yes containerd.io\n'
sudo apt-get remove --assume-yes containerd.io

echo_info 'sudo apt-get remove --assume-yes docker-compose-plugin\n'
sudo apt-get remove --assume-yes docker-compose-plugin

echo_info "rm -r \"${HOME}/.docker/desktop\"\n"
rm -r "${HOME}/.docker/desktop"

echo_info 'sudo rm /usr/local/bin/com.docker.cli\n'
sudo rm /usr/local/bin/com.docker.cli

echo_info 'sudo rm -rf /var/lib/docker\n'
sudo rm -rf /var/lib/docker

echo_info 'sudo rm -rf /var/lib/containerd\n'
sudo rm -rf /var/lib/containerd

echo_info 'sudo apt purge docker-desktop\n'
sudo apt purge docker-desktop

echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

