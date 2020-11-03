#!/bin/bash

#/**
# * imagemagick
# * extract exif info from image file
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes imagemagick'
sudo apt-get install --assume-yes imagemagick
