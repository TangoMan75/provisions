#!/bin/bash

#/**
# * kdenlive
# * Video editor
# *
# * @category multimedia
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes kdenlive'
sudo apt-get install --assume-yes kdenlive
