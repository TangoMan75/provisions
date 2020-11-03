#!/bin/bash

#/**
# * gem
# * ruby gem bundle
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo gem install bundle'
sudo gem install bundle
