#!/bin/bash

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2024 "Matthias Morin" <mat@tangoman.io>>

# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * zenmap
# * nmap network scanner graphic interface
# *
# * @link     https://nmap.org/download.html
# * @link     http://archive.ubuntu.com/ubuntu/pool/universe/n/nmap/
# * @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/
# * @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/
# * @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/
# * @category network
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

PYTHON_GTK2=python-gtk2_2.24.0-5.1ubuntu2_amd64.deb
PYTHON_CAIRO=python-cairo_1.16.2-2ubuntu2_amd64.deb
PYTHON_GOBJECT=python-gobject-2_2.28.6-14ubuntu1_amd64.deb
ZENMAP=zenmap-7.93-1.noarch.rpm
ZENMAP_DEB=zenmap_7.93-2_all.deb

alert_primary "Install $(basename "${ZENMAP}" .rpm)"

if [ ! -x "$(command -v python2)" ]; then
    echo_error "\"$(basename "${0}")\" requires python2, try: 'sudo apt-get install -y python2'"
    exit 1
fi

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

if [ ! -x "$(command -v alien)" ]; then
    echo_error "\"$(basename "${0}")\" requires alien, try: 'sudo apt-get install -y alien'"
    exit 1
fi

if [ ! -x "$(command -v nmap)" ]; then
    echo_error "\"$(basename "${0}")\" requires nmap, try: 'sudo apt-get install -y nmap'"
    exit 1
fi

echo_info "wget \"https://nmap.org/dist/${ZENMAP}\""
wget "https://nmap.org/dist/${ZENMAP}"

echo_info "sudo alien \"${ZENMAP}\""
sudo alien "${ZENMAP}"

echo_info "sudo chmod +777 \"${ZENMAP_DEB}\""
sudo chmod +777 "${ZENMAP_DEB}"

echo_info "sudo dpkg -i \"${ZENMAP_DEB}\""
sudo dpkg -i "${ZENMAP_DEB}"

echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}\""
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}"

echo_info "sudo dpkg -i \"${PYTHON_GTK2}\""
sudo dpkg -i "${PYTHON_GTK2}"

echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/${PYTHON_CAIRO}\""
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/${PYTHON_CAIRO}"

echo_info "sudo dpkg -i \"${PYTHON_CAIRO}\""
sudo dpkg -i "${PYTHON_CAIRO}"

echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/${PYTHON_GOBJECT}\""
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/${PYTHON_GOBJECT}"

echo_info "sudo dpkg -i \"${PYTHON_GOBJECT}\""
sudo dpkg -i "${PYTHON_GOBJECT}"

echo_info "rm -f \"${PYTHON_GTK2}\""
rm -f "${PYTHON_GTK2}"

echo_info "rm -f \"${PYTHON_CAIRO}\""
rm -f "${PYTHON_CAIRO}"

echo_info "rm -f \"${PYTHON_GOBJECT}\""
rm -f "${PYTHON_GOBJECT}"

echo_info "rm -f \"${ZENMAP}\""
rm -f "${ZENMAP}"

echo_info "rm -f \"${ZENMAP_DEB}\""
rm -f "${ZENMAP_DEB}"

