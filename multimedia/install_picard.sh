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
# * picard
# *
# * MusicBrainz Picard mp3 tag
# *
# * @category multimedia
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install picard'

echo_info 'sudo add-apt-repository --yes ppa:musicbrainz-developers/stable'
sudo add-apt-repository --yes ppa:musicbrainz-developers/stable

echo_info 'sudo apt-get update'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes picard'
sudo apt-get install --assume-yes picard
