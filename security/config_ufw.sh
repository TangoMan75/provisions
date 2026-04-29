#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## config_ufw
##
## ufw scans log files (e.g. /var/log/apache/error_log) and bans
## IPs that show the malicious signs -- too many password failures,
## seeking for exploits, etc.
##
## @category security
## @link     https://www.ufw.org

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_alert_primary 'ufw'

#--------------------------------------------------

if [ ! -x "$(command -v ufw)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires ufw, try: 'sudo apt-get install -y ufw'\n"
    exit 1
fi

#--------------------------------------------------

_echo_info 'sudo ufw default deny incoming\n'
sudo ufw default deny incoming

_echo_info 'sudo ufw default allow outgoing\n'
sudo ufw default allow outgoing

_echo_info 'sudo ufw allow 22/tcp\n'
sudo ufw allow 22/tcp

_echo_info 'sudo ufw allow 80/tcp\n'
sudo ufw allow 80/tcp

_echo_info 'sudo ufw allow 8080/tcp\n'
sudo ufw allow 8080/tcp

_echo_info 'sudo ufw allow 443/tcp\n'
sudo ufw allow 443/tcp

