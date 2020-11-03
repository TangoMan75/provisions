#!/bin/bash

#/**
# * whois
# * whois client
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes whois'
sudo apt-get install --assume-yes whois
