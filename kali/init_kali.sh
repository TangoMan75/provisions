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
# * check malware
# *
# * @category kali
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo /usr/sbin/chkrootkit'
sudo /usr/sbin/chkrootkit

echo_info 'sudo rkhunter -c'
sudo rkhunter -c

# update Metasploit
echo_info 'sudo apt-get install --assume-yes metasploit-framework'
sudo apt-get install --assume-yes metasploit-framework
