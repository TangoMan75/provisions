#!/bin/bash

#/**
# * ghex
# *
# * ghex - A GNOME Hex Editor
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes ghex'
sudo apt-get install --assume-yes ghex
