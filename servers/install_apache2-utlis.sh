#!/bin/bash

#/**
# * apache2-utils
# *
# * ```
# * $ htpasswd -nb admin secure_password
# * ```
# *
# * @category servers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes apache2-utils'
sudo apt-get install --assume-yes apache2-utils

