#!/bin/bash

#/**
# * docker-compose
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'curl'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires curl, try: 'sudo apt-get install -y curl'"
    exit 1
fi

echo_info "sudo curl -L \"https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m`\" -o /usr/bin/docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m`" -o /usr/bin/docker-compose

# fix permissions
echo_info 'sudo chmod uga+x /usr/bin/docker-compose'
sudo chmod uga+x /usr/bin/docker-compose

echo_info 'sync'
sync

