#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## check malware
##
## @category kali

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info 'sudo /usr/sbin/chkrootkit\n'
sudo /usr/sbin/chkrootkit

_echo_info 'sudo rkhunter -c\n'
sudo rkhunter -c

# update Metasploit
_echo_info 'sudo apt-get install --assume-yes metasploit-framework\n'
sudo apt-get install --assume-yes metasploit-framework
