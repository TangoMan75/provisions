#!/bin/bash

#/**
# * virtualbox-ext-pack
# * extension pack for virtual box
# *
# * @category devops
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes virtualbox-ext-pack'
sudo apt-get install --assume-yes virtualbox-ext-pack

