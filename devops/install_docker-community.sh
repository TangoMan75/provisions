#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## install the latest version of docker engine - community and containerd
## container environments
##
## @category devops
## @note     NOT RECOMMENDED: install docker.io instead

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

if [ ! -x "$(command -v gpg)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires gnupg, try: 'sudo apt-get install -y gnupg'\n"
    exit 1
fi

if [ ! -x "$(command -v lsb_release)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires lsb-release, try: 'sudo apt-get install -y lsb-release'\n"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes ca-certificates\n'
sudo apt-get install --assume-yes ca-certificates

# add docker's official gpg key
echo_info 'sudo mkdir -p /etc/apt/keyrings\n'
sudo mkdir -p /etc/apt/keyrings

echo_info 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg\n'
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# set up stable repository
echo_info "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null\n"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# update the apt package index
echo_info 'sudo apt-get update\n'
sudo apt-get update

# install the latest version of docker engine - community and containerd
echo_info 'sudo apt-get install --assume-yes docker-ce\n'
sudo apt-get install --assume-yes docker-ce

echo_info 'sudo apt-get install --assume-yes docker-ce-cli\n'
sudo apt-get install --assume-yes docker-ce-cli

echo_info 'sudo apt-get install --assume-yes containerd.io\n'
sudo apt-get install --assume-yes containerd.io

echo_info 'sudo apt-get install --assume-yes docker-compose-plugin\n'
sudo apt-get install --assume-yes docker-compose-plugin

# add current user to docker group
echo_info "sudo usermod -a -G docker \"${USER}\"\n"
sudo usermod -a -G docker "${USER}"

echo_warning 'You will need to log out and log back in current user to use docker'
