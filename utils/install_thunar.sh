#!/bin/bash

#/**
# * thunar
# * bulk rename
# *
# * @category utils
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes --no-install-recommends thunar'
sudo apt-get install --assume-yes --no-install-recommends thunar

echo_info 'sudo apt-get install --assume-yes thunar-media-tags-plugin'
sudo apt-get install --assume-yes thunar-media-tags-plugin
