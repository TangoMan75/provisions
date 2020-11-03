#!/bin/bash

#/**
# * virtualenv
# * python virtual env
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ ! -x "$(command -v pip)" ]; then
    echo_error 'virtualenv requires python-pip to install'
    exit 1
fi

echo_info 'sudo -H pip install virtualenv'
sudo -H pip install virtualenv
