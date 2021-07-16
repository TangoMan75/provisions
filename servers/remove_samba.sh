#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * samba
# * samba file sharing service
# *
# * @category servers
# * @link     https://askubuntu.com/questions/888205/how-to-set-up-an-entire-hard-drive-as-a-shared-drive-in-samba
# * @note     config here: /etc/samba/smb.conf
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get remove --assume-yes samba'
sudo apt-get remove --assume-yes samba

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

