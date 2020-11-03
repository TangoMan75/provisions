#!/bin/bash

#/**
# * weevely
# *
# * php web shell
# *
# * ```bash
# * weevely generate password123! /root/shell.php
# * weevely http://target-url.com/uploads/shell.php
# * ```
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

if [ `is_installed 'python'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires python, try: 'sudo apt-get install -y python'"
    exit 1
fi

if [ `is_installed 'python-pip'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires python-pip, try: 'sudo apt-get install -y python-pip'"
    exit 1
fi

# Make sure that the python package manager and yaml libraries are installed
# echo_info 'sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev'
# sudo apt-get install --assume-yes g++ python2.7 python-pip libyaml-dev python-dev libncurses5-dev

# clone project
echo_info 'git clone --depth 1 https://github.com/epinna/weevely3.git ~/.weevely3'
git clone --depth 1 https://github.com/epinna/weevely3.git ~/.weevely3

# Install requirements from within the .weevely3 folder
(
    echo_info 'cd ~/.weevely3'
    cd ~/.weevely3

    # cleaning git cache
    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'sudo pip install -r requirements.txt --upgrade'
    sudo pip install -r requirements.txt --upgrade
)

