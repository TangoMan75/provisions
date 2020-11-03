#!/bin/bash

#/**
# * rvm
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

echo_info 'gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

echo_info 'curl -sSL https://get.rvm.io | bash -s stable'
curl -sSL https://get.rvm.io | bash -s stable

echo_info 'source ~/.rvm/scripts/rvm'
source ~/.rvm/scripts/rvm
