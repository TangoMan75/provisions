#!/bin/bash

#/**
# * exiftool
# * exif tag editor
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes exiftool'
sudo apt-get install --assume-yes exiftool
