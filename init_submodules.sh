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
# * init submodules
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

echo_info()  { printf '%b%b\033[0m' '\033[95m' "${*}"; }
echo_error() { printf '%berror:\t%b\033[0m' '\033[31m' "${*}"; }

## Initialise git submodules
submodules() {
    # get full parent folder name
    if [ -z "$1" ]; then
        set -- "$(dirname "$(realpath "$0")")"
    else
        set -- "$(dirname "$(realpath "$1")")"
    fi

    if [ ! -d "$1" ]; then
        echo_error "\"$1\" is not a valid directory.\n"
        return 1        
    fi

    if [ ! -f "$1/.gitmodules" ]; then
        echo_error '".gitmodules" not found\n'
        return 1
    fi

    if [ ! -x "$(command -v git)" ] || [ ! -d "$1/.git" ]; then
        # wget should be available by default on Ubuntu
        if [ ! -x "$(command -v wget)" ]; then
            echo_error "\"$(basename "${0}")\" requires wget, try: 'sudo apt-get install -y wget'\n"
            return 1
        fi

        # unzip should be available by default on Ubuntu
        if [ ! -x "$(command -v unzip)" ]; then
            echo_error "\"$(basename "${0}")\" requires unzip, try: 'sudo apt-get install -y unzip'\n"
            return 1
        fi

        # parse .gitmodules
        grep -Eo 'https://.+' "$1/.gitmodules" | while read -r url; do
            repository=$(echo "${url}" | sed -E 's/https:\/\///' | sed -E 's/\.git$//' | tr ':' '/' | cut -d/ -f3)
            # do not update existing submodule
            if [ -n "$(ls -A "${repository}" 2>/dev/null)" ]; then
                continue
            fi

            server=$(echo "${url}" | sed -E 's/https:\/\///' | sed -E 's/\.git$//' | tr ':' '/' | cut -d/ -f1)
            case "${server}" in
                github.com)
                    echo_info "wget -q \"${url}/archive/refs/heads/master.zip\"\n"
                    wget -q "${url}/archive/refs/heads/master.zip"
                ;;
                gitlab.com)
                    echo_info "wget -q \"${url}/-/archive/master/master.zip\"\n"
                    wget -q "${url}/-/archive/master/master.zip"
                ;;
                bitbucket.org)
                    echo_info "wget -q \"${url}/get/master.zip\"\n"
                    wget -q "${url}/get/master.zip"
                ;;
                *) return 1;;
            esac

            echo_info "unzip -qq \"$1/master.zip\"\n"
            unzip -qq "$1/master.zip"

            echo_info "rm \"$1/master.zip\"\n"
            rm "$1/master.zip"

            echo_info "mv \"$1/${repository}-\"* \"$1/${repository}\"\n"
            mv "$1/${repository}-"* "$1/${repository}"
        done

        return 0
    fi

    echo_info 'git submodule update --init --recursive\n'
    git submodule update --init --recursive
}

submodules
