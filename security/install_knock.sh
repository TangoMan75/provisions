#!/bin/bash

#/**
# * knock
# *
# * find unadvertised subdomains
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

echo_info 'git clone --depth 1 https://github.com/guelfoweb/knock.git ~/.knock'
git clone --depth 1 https://github.com/guelfoweb/knock.git ~/.knock

echo_info 'pip install dnspython'
pip install dnspython

# cleaning
echo_info 'rm -rf ~/.knock/.git'
rm -rf ~/.knock/.git

