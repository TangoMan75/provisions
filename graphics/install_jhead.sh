#!/bin/bash

#/**
# * jhead
# * exif jpeg header manipulation tool
# *
# * @category graphics
# * @link     http://www.sentex.net/~mwandel/jhead
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes jhead'
sudo apt-get install --assume-yes jhead
