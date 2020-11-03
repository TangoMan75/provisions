#!/bin/bash

#/**
# * install libre office
# *
# * @category office
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo snap install libreoffice'
sudo snap install libreoffice
