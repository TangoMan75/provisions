#!/bin/bash

#/**
# * remove winehq
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo aptitude purge -y winehq-stable'
sudo aptitude purge -y winehq-stable

