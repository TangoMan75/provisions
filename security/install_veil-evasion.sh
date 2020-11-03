#!/bin/bash

#/**
# * viel-evasion
# *
# * Generate undetectable meterpreter payloads
# *
# * @category security
# * @link     https://github.com/Veil-Framework/Veil
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes viel-evasion'
sudo apt-get install --assume-yes viel-evasion

