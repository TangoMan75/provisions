#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * samba
# *
# * samba file sharing service (default service on ubuntu not NFS as one could expect)
# * 
# * NOTE: use `config_samba.sh` to configure service
# *
# * @category servers
# * @note     config here: /etc/samba/smb.conf
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Samba'

echo_info 'sudo apt-get install --assume-yes samba\n'
sudo apt-get install --assume-yes samba
