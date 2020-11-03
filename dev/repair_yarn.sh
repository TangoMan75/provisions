#!/bin/bash

#/**
# * repair yarn
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get remove --assume-yes cmdtest'
sudo apt-get remove --assume-yes cmdtest

echo_info 'sudo apt-get remove --assume-yes yarn'
sudo apt-get remove --assume-yes yarn

echo_info 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo_info 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list'
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

echo_info 'sudo apt-get update  '
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes yarn'
sudo apt-get install --assume-yes yarn
