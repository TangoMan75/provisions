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

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

if [ `is_installed 'python3-pip'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires python3-pip, try: 'sudo apt-get install -y python3-pip'"
    exit 1
fi

if [ `is_installed 'pipenv'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires pipenv, try: 'pip3 install pipenv'"
    exit 1
fi

echo_info 'mkdir ~/.theHarvester'
mkdir ~/.theHarvester

echo_info 'git clone --depth 1 https://github.com/laramies/theharvester ~/.theHarvester'
git clone --depth 1 https://github.com/laramies/theharvester ~/.theHarvester

# Install requirements from within the .theHarvester folder
(
    echo_info 'cd ~/.theHarvester'
    cd ~/.theHarvester

    # cleaning git cache
    echo_info 'rm -rf .git'
    rm -rf .git

    echo_info 'python3 -m pip install pipenv'
    python3 -m pip install pipenv

    echo_info 'pipenv install'
    pipenv install
)
