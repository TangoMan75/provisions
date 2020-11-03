#!/bin/bash

#/**
# * bash_aliases
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'git clone --depth 1 https://github.com/TangoMan75/bash_aliases ~/bash_aliases'
git clone --depth 1 https://github.com/TangoMan75/bash_aliases ~/bash_aliases

echo_info '(cd ~/bash_aliases && make install)'
(cd ~/bash_aliases && make install)
