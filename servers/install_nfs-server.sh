#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * nfs-server
# * nfs file sharing server
# *
# * @category servers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes nfs-common'
sudo apt-get install --assume-yes nfs-common

echo_info 'sudo apt-get install --assume-yes nfs-kernel-server'
sudo apt-get install --assume-yes nfs-kernel-server

echo_info 'sudo apt-get install --assume-yes nfs-server'
sudo apt-get install --assume-yes nfs-server

# starting nfs-kernel-server
echo_info 'sudo service nfs-kernel-server start'
sudo service nfs-kernel-server start

