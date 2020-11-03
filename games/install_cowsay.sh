#!/bin/bash

#/**
# * cowsay
# * cownsay command line fun
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes cowsay'
sudo apt-get install --assume-yes cowsay
