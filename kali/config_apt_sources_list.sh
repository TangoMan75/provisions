#!/bin/bash

#/**
# * config apt repositories
# *
# * @category kali
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

if [ "$(`lsb_release -is` 2>/dev/null)" = 'Kali' ]; then
    echo_info "sudo sh -c \"echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list\""
    sudo sh -c "echo 'deb http://http.kali.org/kali kali-rolling main non-free contrib'>>/etc/apt/sources.list"

    echo_info 'sudo apt-get update'
    sudo apt-get update
else
    echo_error 'wrong system'
fi
