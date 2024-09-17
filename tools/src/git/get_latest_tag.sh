#!/bin/bash

#/*
# * This file is part of TangoMan Bash Tools package.
# *
# * Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan Bash Tools
# *
# * A set of tools for shell scripts
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Get repository latest tag from github
function get_latest_tag() {
    if [ ! -x "$(command -v curl)" ]; then
        echo_error "\"${FUNCNAME[0]}\" requires curl, try: 'sudo apt-get install -y curl'"

        return 1
    fi

    local REPOSITORY=$1

    OPTIND=0
    while getopts :h OPTION; do
        case "${OPTION}" in
            h|*) echo_warning "${FUNCNAME[0]}";
                echo_label 16 'description:'; echo_primary 'Get repository latest tag'
                echo_label 16 'usage:'; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)"
                return 0;;
        esac
    done

    if [ "$#" -lt 1 ]; then
        echo_error 'some mandatory parameter is missing'
        echo_label 8 'usage:'; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)"
        return 1
    fi

    if [ "$#" -gt 1 ]; then
        echo_error "too many arguments ($#)"
        echo_label 8 'usage:'; echo_primary "${FUNCNAME[0]} [owner/repository] -h (help)"
        return 1
    fi

    curl --silent "https://api.github.com/repos/${REPOSITORY}/tags" |
        grep -m 1 '"name":' |             # find first tag name
        sed -E 's/.*"[vV]?([^"]+)".*/\1/' # remove quotes and leading v if any
}
