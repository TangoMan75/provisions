#!/bin/bash

#/**
# * id3tool
# * mp3 tags editor
# *
# * @category multimedia
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes id3tool'
sudo apt-get install --assume-yes id3tool
