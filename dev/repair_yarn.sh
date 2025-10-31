#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## repair yarn
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

echo_info 'sudo apt-get remove --assume-yes cmdtest\n'
sudo apt-get remove --assume-yes cmdtest

echo_info 'sudo apt-get remove --assume-yes yarn\n'
sudo apt-get remove --assume-yes yarn

echo_info 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -\n'
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo_info 'echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list\n'
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

echo_info 'sudo apt-get update  \n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes yarn\n'
sudo apt-get install --assume-yes yarn
