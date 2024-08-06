#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * fingerprint reader
# *
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info "sudo sh -c \"cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF\""
sudo sh -c "cat > /etc/apt/sources.list.d/$(lsb_release -cs 2>/dev/null)-dell.list << EOF
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-dell public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-oem public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville public
deb http://dell.archive.canonical.com/updates/ $(lsb_release -cs 2>/dev/null)-somerville-melisa public
EOF"

echo_info 'sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F9FDA6BED73CDC22

echo_info 'sudo apt update -qq'
sudo apt update -qq

echo_info 'sudo apt install -y oem-somerville-melisa-meta'
sudo apt install -y oem-somerville-melisa-meta

echo_info 'sudo apt install -y libfprint-2-tod1-goodix'
sudo apt install -y libfprint-2-tod1-goodix

echo_info 'sudo apt install -y oem-somerville-meta'
sudo apt install -y oem-somerville-meta

#--------------------------------------------------

echo_info 'sudo apt install -y tlp-config'
sudo apt install -y tlp-config

#--------------------------------------------------

echo_info 'sudo add-apt-repository --yes ppa:boltgolt/howdy -y'
sudo add-apt-repository --yes ppa:boltgolt/howdy -y

echo_info 'sudo apt update -qq'
sudo apt update -qq

echo_info 'sudo apt install howdy -y'
sudo apt install howdy -y
