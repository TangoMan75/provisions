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

## Get repository latest tag from github
function get_latest_tag() {
    if [ ! -x "$(command -v curl)" ]; then
        echo_danger "error: \"${FUNCNAME[0]}\" requires curl, try: 'sudo apt-get install -y curl'\n"

        return 1
    fi

    local REPOSITORY=$1

    OPTIND=0
    while getopts :h OPTION; do
        case "${OPTION}" in
            h|*) echo_warning "${FUNCNAME[0]}";
                echo_success 'description:' 2 14; echo_primary 'Get repository latest tag\n'
                echo_success 'usage:' 2 14; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)\n"
                return 0;;
        esac
    done

    if [ "$#" -lt 1 ]; then
        echo_danger 'error: some mandatory parameter is missing'
        echo_success 'usage:' 2 7; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)\n"
        return 1
    fi

    if [ "$#" -gt 1 ]; then
        echo_danger "error: too many arguments ($#)\n"
        echo_success 'usage:' 2 7; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)\n"
        return 1
    fi

    curl --silent "https://api.github.com/repos/${REPOSITORY}/tags" |
        grep -m 1 '"name":' |             # find first tag name
        sed -E 's/.*"[vV]?([^"]+)".*/\1/' # remove quotes and leading v if any
}
