#!/bin/bash

#/**
# * remove rvm
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# uninstall rvm
echo_caption 'uninstall rvm'
# This will remove the rvm/ directory and all the rubies built within it.
echo_info 'rvm implode'
rvm implode

# In order to remove the final trace of rvm, you need to remove the rvm gem, too:
echo_info 'gem uninstall rvm'
gem uninstall rvm

echo_info 'rm -rf /etc/rvmrc'
rm -rf /etc/rvmrc

echo_info 'rm -rf ~/.rvmrc'
rm -rf ~/.rvmrc

