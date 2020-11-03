#!/bin/bash

#/**
# * ansible-alt
# *
# * @note     alternative install method with pip/virtual env
# * @link     https://docs.ansible.com
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'pip'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires pip, try: 'sudo apt-get install -y pip'"
    exit 1
fi

echo_info 'adduser user-ansible'
adduser user-ansible

echo_info 'sudo apt-get install --assume-yes python-virtualenv'
sudo apt-get install --assume-yes python-virtualenv

echo_info 'sudo apt-get install --assume-yes sshpass'
sudo apt-get install --assume-yes sshpass

echo_info 'su - user-ansible'
su - user-ansible

# create virtual env
echo_info 'virtualenv ansible2.7.10'
virtualenv ansible2.7.10

# enable virtual env
echo_info 'source ansible2.7.10/bin/activate'
source ansible2.7.10/bin/activate

# install ansible in virtualenv with pip
echo_info 'pip install ansible==2.7.10'
pip install ansible==2.7.10

echo_info 'ansible --version'
ansible --version

