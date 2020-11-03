#!/bin/bash

#/**
# * csvtool
# * csvtool is a tool for performing manipulations on csv files from shell scripts
# *
# * @category dev
# * @link     http://colin.maudry.com/csvtool-manual-page
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes csvtool'
sudo apt-get install --assume-yes csvtool
