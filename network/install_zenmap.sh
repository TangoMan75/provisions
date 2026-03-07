#!/bin/bash

#/*
## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>>

##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## zenmap
## nmap network scanner graphic interface
##
## @link     https://nmap.org/download.html
## @link     http://archive.ubuntu.com/ubuntu/pool/universe/n/nmap/
## @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/
## @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/
## @link     http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/
## @category network

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

PYTHON_GTK2=python-gtk2_2.24.0-5.1ubuntu2_amd64.deb
PYTHON_CAIRO=python-cairo_1.16.2-2ubuntu2_amd64.deb
PYTHON_GOBJECT=python-gobject-2_2.28.6-14ubuntu1_amd64.deb
# ZENMAP=zenmap-7.93-1.noarch.rpm
# ZENMAP_DEB=zenmap_7.93-2_all.deb
ZENMAP=zenmap-7.95-1.noarch.rpm
ZENMAP_DEB=zenmap_7.95-2_all.deb

_alert_primary "Install $(basename "${ZENMAP}" .rpm)"

if [ ! -x "$(command -v python2)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires python2, try: 'sudo apt-get install -y python2'\n"
    exit 1
fi

if [ ! -x "$(command -v wget)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
    exit 1
fi

if [ ! -x "$(command -v alien)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires alien, try: 'sudo apt-get install -y alien'\n"
    exit 1
fi

if [ ! -x "$(command -v nmap)" ]; then
    _echo_danger "error: \"$(basename "${0}")\" requires nmap, try: 'sudo apt-get install -y nmap'\n"
    exit 1
fi

_echo_info "wget \"https://nmap.org/dist/${ZENMAP}\"\n"
wget "https://nmap.org/dist/${ZENMAP}"

_echo_info "sudo alien \"${ZENMAP}\"\n"
sudo alien "${ZENMAP}"

_echo_info "sudo chmod +777 \"${ZENMAP_DEB}\"\n"
sudo chmod +777 "${ZENMAP_DEB}"

_echo_info "sudo dpkg --install \"${ZENMAP_DEB}\"\n"
sudo dpkg --install "${ZENMAP_DEB}"

_echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}\"\n"
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pygtk/${PYTHON_GTK2}"

_echo_info "sudo dpkg --install \"${PYTHON_GTK2}\"\n"
sudo dpkg --install "${PYTHON_GTK2}"

_echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/${PYTHON_CAIRO}\"\n"
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/${PYTHON_CAIRO}"

_echo_info "sudo dpkg --install \"${PYTHON_CAIRO}\"\n"
sudo dpkg --install "${PYTHON_CAIRO}"

_echo_info "wget \"http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/${PYTHON_GOBJECT}\"\n"
wget "http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/${PYTHON_GOBJECT}"

_echo_info "sudo dpkg --install \"${PYTHON_GOBJECT}\"\n"
sudo dpkg --install "${PYTHON_GOBJECT}"

_echo_info "rm -f \"${PYTHON_GTK2}\"\n"
rm -f "${PYTHON_GTK2}"

_echo_info "rm -f \"${PYTHON_CAIRO}\"\n"
rm -f "${PYTHON_CAIRO}"

_echo_info "rm -f \"${PYTHON_GOBJECT}\"\n"
rm -f "${PYTHON_GOBJECT}"

_echo_info "rm -f \"${ZENMAP}\"\n"
rm -f "${ZENMAP}"

_echo_info "rm -f \"${ZENMAP_DEB}\"\n"
rm -f "${ZENMAP_DEB}"

