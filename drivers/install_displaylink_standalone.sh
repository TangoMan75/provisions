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
# * DisplayLink
# *
# * driver for supported DisplayLink USB graphics device
# *
# * @link     https://www.synaptics.com/products/displaylink-graphics/downloads/ubuntu
# * @link     https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

if [ ! -x "$(command -v wget)" ]; then
    echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'"
    exit 1
fi

echo_info 'sudo apt-get install --assume-yes dkms'
sudo apt-get install --assume-yes dkms

echo_info 'sudo apt-get install --assume-yes libdrm-dev'
sudo apt-get install --assume-yes libdrm-dev

DATE='2023-08'

BASENAME="DisplayLink USB Graphics Software for Ubuntu5.8-EXE"
FILE_NAME="${BASENAME}.zip"
EXECUTABLE="displaylink-driver-5.8.0-63.33.run"

alert_primary "Install ${BASENAME}"

if [ ! -f "${FILE_NAME}" ]; then
    echo_info "wget \"https://www.synaptics.com/sites/default/files/exe_files/${DATE}/${FILE_NAME}\""
    wget "https://www.synaptics.com/sites/default/files/exe_files/${DATE}/${FILE_NAME}"
fi

if [ ! -d temp ]; then
    # unzip in current directory
    echo_info "unzip -d temp \"${FILE_NAME}\""
    unzip -d temp "${FILE_NAME}"
fi

# make binary executable
echo_info "sudo chmod uga+x \"temp/${EXECUTABLE}\""
sudo chmod uga+x "temp/${EXECUTABLE}"

# execute install
echo_info "sudo ./temp/${EXECUTABLE}"
sudo ./temp/${EXECUTABLE}

# clean archive
while [ -f "${FILE_NAME}" ]; do
    echo_info "rm -f \"${FILE_NAME}\""
    rm -f "${FILE_NAME}"
    sleep 1
done

while [ -d "temp" ]; do
    # clean download folder
    echo_info "rm -rf temp"
    rm -rf temp
    sleep 1
done

