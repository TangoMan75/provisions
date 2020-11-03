#!/bin/bash

#/**
# * netfilterqueue
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

echo_info 'sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev'
sudo apt-get install --assume-yes build-essential python-dev libnetfilter-queue-dev

echo_info 'mkdir ~/.netfilterqueue'
mkdir ~/.netfilterqueue

echo_info 'git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue'
git clone --depth 1 https://github.com/kti/python-netfilterqueue.git ~/.netfilterqueue

(
    echo_info 'cd ~/.netfilterqueue'
    cd ~/.netfilterqueue

    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'sudo python setup.py install'
    sudo python setup.py install
)
