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
# * remove nfs file sharing server
# *
# * @category servers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

# stopping nfs-kernel-server
echo_info 'sudo service nfs-kernel-server stop'
sudo service nfs-kernel-server stop

# uninstall nfs server
echo_warning 'uninstall nfs'

echo_info 'sudo dpkg --purge nfs-kernel-server'
sudo dpkg --purge nfs-kernel-server

echo_info 'sudo dpkg --purge nfs-common'
sudo dpkg --purge nfs-common

