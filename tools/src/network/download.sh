#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Bash Tools
##
## A set of tools for shell scripts
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

## Download file with either curl or wget
function download() {
    local DOWNLOADER

    if [ ! -x "$(command -v curl)" ]; then
        DOWNLOADER="curl"
    elif [ ! -x "$(command -v wget)" ]; then
        DOWNLOADER="wget"
    else
        _echo_danger "error: \"$(basename "${0}")\" requires curl or wget, try: 'sudo apt-get install -y curl'\n"

        return 1
    fi

    case ${DOWNLOADER} in
        'curl')
            # -s sient -S show errors -L follow redirects
            _echo_info "curl -sSL \"$1\"\n"
            curl -sSL "$1"
            ;;
        'wget')
            # -q sient
            _echo_info "wget -q \"$1\"\n"
            wget -q "$1"
            ;;
    esac
}

