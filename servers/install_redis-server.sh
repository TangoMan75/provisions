#!/bin/bash

#/**
# * redis-server
# * cache server
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes redis-server'
sudo apt-get install --assume-yes redis-server
