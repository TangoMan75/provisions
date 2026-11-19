#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## tesseract
##
## Tesseract is an open source OCR (Optical Character Recognition) engine
## that supports over 100 languages. It provides a command line tool and
## a C/C++ library for extracting text from images in various formats
## including PNG, JPEG and TIFF.
##
## ```bash
## # example usage
## tesseract image.jpg output
## ```
## ```bash
## tesseract input.jpg output --oem 3 --psm 6
## ```
## 
## - `input.jpg` - your image file
## - `output` - base name for output files (creates `output.txt`)
## - `--oem 3` - default LSTM engine
## - `--psm 6` - assume uniform block of text
## 
## Adjust `--psm` value if needed:
## - `1` = auto-detect orientation/skew
## - `3` = fully automatic (default)
## - `6` = uniform block of text
## - `11` = sparse text without order
## - `13` = raw line
## 
## To output just the text to stdout:
## 
## ```bash
## tesseract input.jpg stdout
## ```
##
## To output the text to file with language support:
## ```bash
## tesseract image.jpg output -l eng+fra
## ```
##
## @category cli
## @link     https://github.com/tesseract-ocr/tesseract
## @link     https://tesseract-ocr.github.io/tessdoc/Installation.html



CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

APP_NAME=tesseract

#--------------------------------------------------

_alert_primary "Install ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get update\n"
sudo apt-get update

_echo_info "sudo apt-get install --assume-yes tesseract-ocr libtesseract-dev\n"
sudo apt-get install --assume-yes tesseract-ocr libtesseract-dev

_echo_warning 'Optional: install English language data\n'

_echo_info "sudo apt-get install --assume-yes tesseract-ocr-eng\n"
sudo apt-get install --assume-yes tesseract-ocr-eng

_echo_warning 'Optional: install additional language data (e.g. French, German, Spanish)\n'

_echo_info "sudo apt-get install --assume-yes tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-spa\n"
sudo apt-get install --assume-yes tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-spa
