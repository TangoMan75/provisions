#!/bin/bash

#/**
# * update nodejs
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'npm'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires npm, try: 'sudo apt-get install -y npm'"
    exit 1
fi

echo_info 'sudo npm install -g n'
sudo npm install -g n

echo_info 'sudo n latest'
sudo n latest

