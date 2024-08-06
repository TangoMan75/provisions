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
# * install wkhtmltopdf
# *
# * convert html to pdf
# *
# * Not recommended try pandoc instead.
# *
# * Convert `html` to `pdf` with `css` and `<img>`
# *
# * ```
# * wkhtmltopdf --enable-local-file-access example.html example.pdf
# * ```
# *
# * @category office
# */

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

echo_info 'sudo apt-get install --assume-yes wkhtmltopdf'
sudo apt-get install --assume-yes wkhtmltopdf

