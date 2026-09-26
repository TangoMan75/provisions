#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install the latest version of docker engine - community and containerd
## container environments
##
## @category devops
## @note     this is the recommended version for debian / kali

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

# add docker's official gpg key
_echo_info 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -\n'
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# set up stable repository
_echo_info "sudo add-apt-repository --yes \"deb [arch=amd64] https://download.docker.com/linux/debian buster stable\"\n"
sudo add-apt-repository --yes "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"

# echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list

# update the apt package index
_echo_info 'sudo apt-get update\n'
sudo apt-get update

# install the latest version of docker engine - community and containerd
_echo_info 'sudo apt-get install --assume-yes docker-ce\n'
sudo apt-get install --assume-yes docker-ce

# add current user to docker group
_echo_info "sudo usermod -a -G docker \"${USER}\"\n"
sudo usermod -a -G docker "${USER}"

_echo_warning 'You will need to log out and log back in current user to use docker'
