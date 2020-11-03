#!/bin/bash

#/**
# * remove docker
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

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

