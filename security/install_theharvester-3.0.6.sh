#!/bin/bash

#/**
# * theHarvester
# *
# * @category security
# * @link     https://github.com/laramies/theHarvester
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

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

echo_info 'wget https://github.com/laramies/theHarvester/archive/3.0.6.tar.gz'
wget https://github.com/laramies/theHarvester/archive/3.0.6.tar.gz

echo_info 'tar xvzf 3.0.6.tar.gz'
tar xvzf 3.0.6.tar.gz

echo_info 'mv ./theHarvester-3.0.6 ~/.theHarvester'
mv ./theHarvester-3.0.6 ~/.theHarvester

echo_info 'rm -rf 3.0.6.tar.gz'
rm -rf 3.0.6.tar.gz

echo_info 'pip install --user -r ~/.theHarvester/requirements.txt'
pip install --user -r ~/.theHarvester/requirements.txt
