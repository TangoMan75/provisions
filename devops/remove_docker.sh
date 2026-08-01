#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove docker
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_danger 'Remove docker'

_echo_info 'sudo apt-get remove --assume-yes docker\n'
sudo apt-get remove --assume-yes docker

_echo_info 'sudo apt-get remove --assume-yes docker-engine\n'
sudo apt-get remove --assume-yes docker-engine

_echo_info 'sudo apt-get remove --assume-yes docker.io\n'
sudo apt-get remove --assume-yes docker.io

_echo_info 'sudo apt-get remove --assume-yes docker-ce\n'
sudo apt-get remove --assume-yes docker-ce

_echo_info 'sudo apt-get remove --assume-yes docker-ce-cli\n'
sudo apt-get remove --assume-yes docker-ce-cli

_echo_info 'sudo apt-get remove --assume-yes containerd.io\n'
sudo apt-get remove --assume-yes containerd.io

_echo_info 'sudo apt-get remove --assume-yes docker-compose-plugin\n'
sudo apt-get remove --assume-yes docker-compose-plugin

_echo_info "rm -r \"${HOME}/.docker/desktop\"\n"
rm -r "${HOME}/.docker/desktop"

_echo_info 'sudo rm /usr/local/bin/com.docker.cli\n'
sudo rm /usr/local/bin/com.docker.cli

_echo_info 'sudo rm -rf /var/lib/docker\n'
sudo rm -rf /var/lib/docker

_echo_info 'sudo rm -rf /var/lib/containerd\n'
sudo rm -rf /var/lib/containerd

_echo_info 'sudo apt purge docker-desktop\n'
sudo apt purge docker-desktop

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove

