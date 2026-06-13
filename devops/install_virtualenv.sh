#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## virtualenv
## python virtual env
##
## @category devops

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

if [ ! -x "$(command -v pip)" ]; then
    _echo_danger 'error: virtualenv requires python-pip to install'
    exit 1
fi

# The -H (HOME) option requests that the security policy set the HOME environment variable to
# the home directory of the target user (root by default) as specified by the password
# database.  Depending on the policy, this may be the default behavior.
_echo_info 'sudo -H pip3 install virtualenv\n'
sudo -H pip3 install virtualenv

