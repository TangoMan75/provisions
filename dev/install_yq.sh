#!/bin/bash

#/**
# * yq
# * command-line yaml/xml processor - jq wrapper for yaml and xml documents
# *
# * @category dev
# * @link     https://yq.readthedocs.io/en/latest
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ ! -x "$(command -v pip)" ]; then
    echo_error 'template requires python-pip to install'
    exit 1
fi

echo_info 'pip install yq'
pip install yq
