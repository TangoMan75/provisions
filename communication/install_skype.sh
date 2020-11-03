#!/bin/bash

#/**
# * skype
# *
# * @category communication
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ ! -x "$(command -v snap)" ]; then
    echo_error 'skype requires snapd to install'
    exit 1
fi

echo_info 'sudo snap install skype --classic'
sudo snap install skype --classic
