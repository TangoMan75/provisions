#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## ansible-alt
##
## @note     alternative install method with pip/virtual env
## @link     https://docs.ansible.com
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v pip3)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'\n"
    exit 1
fi

echo_info 'adduser user-ansible\n'
adduser user-ansible

echo_info 'sudo apt-get install --assume-yes python-virtualenv\n'
sudo apt-get install --assume-yes python-virtualenv

echo_info 'sudo apt-get install --assume-yes sshpass\n'
sudo apt-get install --assume-yes sshpass

echo_info 'su - user-ansible\n'
su - user-ansible

# create virtual env
echo_info 'virtualenv ansible2.7.10\n'
virtualenv ansible2.7.10

# enable virtual env
echo_info 'source ansible2.7.10/bin/activate\n'
# shellcheck source=/dev/null
source ansible2.7.10/bin/activate

# install ansible in virtualenv with pip
echo_info 'pip3 install ansible==2.7.10\n'
pip3 install ansible==2.7.10

echo_info 'ansible --version\n'
ansible --version

