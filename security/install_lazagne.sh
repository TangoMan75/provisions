#!/bin/bash

#/**
# * LaZagne
# *
# * recover locally stored passwords
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'wget'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ `is_installed 'unzip'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires unzip, try: 'sudo apt-get install -y unzip'"
    exit 1
fi

echo_info 'wget -q https://github.com/AlessandroZ/LaZagne/releases/download/1.0/Linux-64bits.zip'
wget -q https://github.com/AlessandroZ/LaZagne/releases/download/1.0/Linux-64bits.zip

echo_info 'unzip Linux-64bits.zip -d ./'
unzip Linux-64bits.zip -d ./

echo_info 'mv ./Linux-64bits ~/.LaZagne'
mv ./Linux-64bits ~/.LaZagne

echo_info 'chmod 755 ~/.LaZagne/LaZagne-64bits'
chmod 755 ~/.LaZagne/LaZagne-64bits

echo_info 'rm -f ./Linux-64bits.zip'
rm -f ./Linux-64bits.zip

