#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
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

#--------------------------------------------------

if [ ! -x "$(command -v pip3)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires pip3, try: 'sudo apt-get install -y pip3'\n"
    exit 1
fi

_echo_info 'adduser user-ansible\n'
adduser user-ansible

_echo_info 'sudo apt-get install --assume-yes python-virtualenv\n'
sudo apt-get install --assume-yes python-virtualenv

_echo_info 'sudo apt-get install --assume-yes sshpass\n'
sudo apt-get install --assume-yes sshpass

_echo_info 'su - user-ansible\n'
su - user-ansible

# create virtual env
_echo_info 'virtualenv ansible2.7.10\n'
virtualenv ansible2.7.10

# enable virtual env
_echo_info 'source ansible2.7.10/bin/activate\n'
# shellcheck source=/dev/null
source ansible2.7.10/bin/activate

# install ansible in virtualenv with pip
_echo_info 'pip3 install ansible==2.7.10\n'
pip3 install ansible==2.7.10

_echo_info 'ansible --version\n'
ansible --version

