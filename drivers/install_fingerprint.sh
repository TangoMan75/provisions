#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## fingerprint reader
##
## @category drivers

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

_echo_info "sudo sh -c \"cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF\"\n"
sudo sh -c "cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-dell public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-oem public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville-melisa public
EOF"

_echo_info 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22\n'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22

_echo_info 'sudo apt update -qq\n'
sudo apt update -qq

_echo_info 'sudo apt install -y oem-somerville-melisa-meta\n'
sudo apt install -y oem-somerville-melisa-meta

_echo_info 'sudo apt install -y libfprint-2-tod1-goodix\n'
sudo apt install -y libfprint-2-tod1-goodix

_echo_info 'sudo apt install -y oem-somerville-meta\n'
sudo apt install -y oem-somerville-meta

#--------------------------------------------------

_echo_info 'sudo apt install -y tlp-config\n'
sudo apt install -y tlp-config

#--------------------------------------------------

_echo_info 'sudo add-apt-repository --yes ppa:boltgolt/howdy -y\n'
sudo add-apt-repository --yes ppa:boltgolt/howdy -y

_echo_info 'sudo apt update -qq\n'
sudo apt update -qq

_echo_info 'sudo apt install howdy -y\n'
sudo apt install howdy -y
