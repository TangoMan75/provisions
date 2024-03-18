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
# * Config fix cache has no package error
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @category drivers
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

OPTIND=0
while getopts :h OPTION; do
    case "${OPTION}" in
        h) echo_label 12 'description'; echo_primary "$(basename "${0}"): disable grub splash screen to avoid freeze on boot"
            echo_label 12 'usage'; echo_primary "$(basename "${0}") -h (help)"
            exit 0;;
        \?) echo_error "invalid option \"${OPTARG}\""
            exit 1;;
    esac
done

alert_primary 'Fix cache has no package error'

# Unknown Error: <class 'KeyError'> ("The cache has no package named libheif1:amd64")
echo_warning "Unknown Error: <class 'KeyError'> (\"The cache has no package named libheif1:amd64\")"

echo_info 'sudo apt-get install --reinstall libheif1'
sudo apt-get install --reinstall libheif1

# Unknown Error: <class 'KeyError'> ("The cache has no package named libgav1-0:amd64")
echo_warning "Unknown Error: <class 'KeyError'> (\"The cache has no package named libgav1-0:amd64\")"

echo_info 'sudo apt-get install --reinstall libgav1-0'
sudo apt-get install --reinstall libgav1-0

# Unknown Error: <class 'KeyError'> ("The cache has no package named libyuv0:amd64")
echo_warning "Unknown Error: <class 'KeyError'> (\"The cache has no package named libyuv0:amd64\")"

echo_info 'sudo apt-get install --reinstall libyuv0'
sudo apt-get install --reinstall libyuv0

# Unknown Error: <class 'KeyError'> ("The cache has no package named libavif13:amd64")
echo_warning "Unknown Error: <class 'KeyError'> (\"The cache has no package named libavif13:amd64\")"

echo_info 'sudo apt-get install --reinstall libavif13'
sudo apt-get install --reinstall libavif13
