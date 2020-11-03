#!/bin/bash

#/**
# * curl
# * http client
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes libcurl4 curl'
sudo apt-get install --assume-yes libcurl4 curl
