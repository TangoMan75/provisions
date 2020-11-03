#!/bin/bash

#/**
# * corkscrew
# *
# * Get ssh through firewall and proxies, with http tunneling
# *
# * ```shell
# * $ ssh -p 22 -o 'ProxyCommand corckscrew -p 192.168.1.1 8118 %h %p' -D 8080 user@remote.dev
# * ```
# *
# * @category security
# * @link     https://github.com/bryanpkc/corkscrew
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes corkscrew'
sudo apt-get install --assume-yes corkscrew

