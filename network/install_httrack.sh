#!/bin/bash

#/**
# * httrack
# * website downloader
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes httrack'
sudo apt-get install --assume-yes httrack
