#!/bin/bash

#/**
# * sherlock
# *
# * @category security
# * @note     cd ~/.sherlock/ && python3 sherlock.py
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

if [ `is_installed 'python3-pip'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'"
    exit 1
fi

echo_info 'mkdir ~/.sherlock'
mkdir ~/.sherlock

echo_info 'git clone --depth 1 https://github.com/sherlock-project/sherlock ~/.sherlock'
git clone --depth 1 https://github.com/sherlock-project/sherlock ~/.sherlock

(
    echo_info 'cd ~/.sherlock'
    cd ~/.sherlock

    echo_info 'rm -rf .git'
    rm -rf .git

    # echo_info 'sudo pip3 install --user --upgrade setuptools'
    # sudo pip3 install --user --upgrade setuptools

    echo_info 'sudo pip3 install --user -r requirements.txt'
    sudo pip3 install --user -r requirements.txt
)
