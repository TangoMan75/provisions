#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## mysql-server
## database server
##
## @category servers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes wget ca-certificates\n'
sudo apt-get install --assume-yes wget ca-certificates

echo_info 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -\n'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

echo_info "sudo sh -c 'echo \"deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main\" >> /etc/apt/sources.list.d/pgdg.list'\n"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install postgresql postgresql-contrib\n'
sudo apt-get install postgresql postgresql-contrib
