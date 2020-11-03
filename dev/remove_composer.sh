#!/bin/bash

#/**
# * remove composer
# *
# * @category dev
# 
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo rm -f /usr/local/bin/composer'
sudo rm -f /usr/local/bin/composer

