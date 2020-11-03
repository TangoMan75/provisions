#!/bin/bash

#/**
# * jq
# * jq is a lightweight and flexible command-line json processor
# *
# * @category dev
# * @link     https://stedolan.github.io/jq
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes jq'
sudo apt-get install --assume-yes jq
