#!/bin/bash

#/**
# * awscli
# * amazon s3 client
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ ! -x "$(command -v pip)" ]; then
    echo_error 'awscli requires python-pip to install'
    exit 1
fi

echo_info 'pip install awscli'
pip install awscli
