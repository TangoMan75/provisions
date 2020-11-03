#!/bin/bash

#/**
# * android-sdk-tools
# *
# * @category drivers
# * @link     https://developer.android.com/studio#downloads
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

echo_info 'wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip'
wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip

echo_info 'unzip sdk-tools-linux-4333796.zip -d ./'
unzip sdk-tools-linux-4333796.zip -d ./

echo_info 'mv ./tools ~/.android-sdk-tools'
mv ./tools ~/.android-sdk-tools

echo_info 'rm -f ./sdk-tools-linux-4333796.zip'
rm -f ./sdk-tools-linux-4333796.zip

