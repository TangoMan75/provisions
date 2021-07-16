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
# * install the latest version of docker engine - community and containerd
# * container environments
# *
# * @category devops
# * @note     not recommended: install docker.io instead
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v curl)" ]; then
    echo_error "\"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

if [ ! -x "$(command -v apt-transport-https)" ]; then
    # install packages to allow apt to use a repository over https
    echo_info 'sudo apt-get install --assume-yes apt-transport-https'
    sudo apt-get install --assume-yes apt-transport-https
fi

if [ ! -x "$(command -v ca-certificates)" ]; then
    echo_info 'sudo apt-get install --assume-yes ca-certificates'
    sudo apt-get install --assume-yes ca-certificates
fi

if [ ! -x "$(command -v gnupg-agent)" ]; then
    echo_info 'sudo apt-get install --assume-yes gnupg-agent'
    sudo apt-get install --assume-yes gnupg-agent
fi

if [ ! -x "$(command -v software-properties-common)" ]; then
    echo_info 'sudo apt-get install --assume-yes software-properties-common'
    sudo apt-get install --assume-yes software-properties-common
fi

# add docker's official gpg key
echo_info 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# set up stable repository
echo_info "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\""
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# update the apt package index
echo_info 'sudo apt-get update'
sudo apt-get update

# install the latest version of docker engine - community and containerd
echo_info 'sudo apt-get install --assume-yes docker-ce'
sudo apt-get install --assume-yes docker-ce

echo_info 'sudo apt-get install --assume-yes docker-ce-cli'
sudo apt-get install --assume-yes docker-ce-cli

echo_info 'sudo apt-get install --assume-yes containerd.io'
sudo apt-get install --assume-yes containerd.io

# add current user to docker group
echo_info "sudo usermod -a -G docker \"${USER}\""
sudo usermod -a -G docker "${USER}"

echo_warning 'You will need to log out and log back in current user to use docker'
