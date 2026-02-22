#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## rvm
##
## @category dev

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v curl)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires curl, try: 'sudo apt-get install -y curl'\n"
    exit 1
fi

_echo_info 'gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB\n'
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

_echo_info 'curl -sSL https://get.rvm.io | bash -s stable\n'
curl -sSL https://get.rvm.io | bash -s stable

_echo_info 'source ~/.rvm/scripts/rvm\n'
# shellcheck disable=SC1090
source ~/.rvm/scripts/rvm
