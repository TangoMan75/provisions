#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## remove tesseract
##
## Tesseract is an open source OCR (Optical Character Recognition) engine
## that supports over 100 languages. It provides a command line tool and
## a C/C++ library for extracting text from images in various formats
## including PNG, JPEG and TIFF.
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

_alert_danger "Remove ${APP_NAME}"

#--------------------------------------------------

_echo_info "sudo apt-get remove -y tesseract-ocr libtesseract-dev\n"
sudo apt-get remove -y tesseract-ocr libtesseract-dev

_echo_info "sudo apt-get remove -y tesseract-ocr-eng tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-spa\n"
sudo apt-get remove -y tesseract-ocr-eng tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-spa

#--------------------------------------------------

_echo_info 'sudo apt-get --assume-yes autoremove\n'
sudo apt-get --assume-yes autoremove
