#!/bin/bash

#/**
# * install the latest version of docker engine - community and containerd
# * container environments
# *
# * @category devops
# * @note     this is the recommended version for debian / kali
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

# add docker's official gpg key
echo_info 'curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -'
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# set up stable repository
echo_info "sudo add-apt-repository \"deb [arch=armhf] https://download.docker.com/linux/debian buster stable\""
sudo add-apt-repository "deb [arch=armhf] https://download.docker.com/linux/debian buster stable"

# echo 'deb [arch=armhf] https://download.docker.com/linux/debian buster stable' | sudo tee /etc/apt/sources.list.d/docker.list

# update the apt package index
echo_info 'sudo apt-get update'
sudo apt-get update

# install the latest version of docker engine - community and containerd
echo_info 'sudo apt-get install --assume-yes docker-ce'
sudo apt-get install --assume-yes docker-ce

# add current user to docker group
echo_info "sudo usermod -a -G docker ${USER}"
sudo usermod -a -G docker ${USER}

echo_warning 'You will need to log out and log back in current user to use docker'
