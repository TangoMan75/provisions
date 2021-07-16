#!/bin/sh
set -e

#/*
# * This file is part of TangoMan Entrypoint package.
# *
# * Copyright (c) 2021 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * TangoMan CI Manager
# *
# * Run Continuous Integration
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# * @version 2.4.1-light
# * @link    https://github.com/TangoMan75/entrypoint
# */

## Install git hooks
hooks() {
    echo_info 'rm -fr .git/hooks\n'
    rm -fr .git/hooks

    echo_info 'cp -r .githooks .git/hooks\n'
    cp -r .githooks .git/hooks

    echo_info 'chmod +x .git/hooks/*\n'
    chmod +x .git/hooks/*
}

## Sniff errors with linter
lint() {
    if [ ! -x "$(command -v shellcheck)" ]; then
        echo_error "\"$(basename "${0}")\" requires shellcheck, try: 'sudo apt-get install -y shellcheck'\n"
        exit 1
    fi

    find . -maxdepth 3 -type f -name '*.sh' | sort -t '\0' -n | while read -r FILE
    do
        echo_info "shellcheck \"${FILE}\"\n"
        shellcheck "${FILE}"
    done
}

#--------------------------------------------------
# copy/paste here TangoMan helper functions
# (like a nice set of semantic colors)
#--------------------------------------------------

# version v7.0.0-c
echo_info()  { printf '%b%b\033[0m' '\033[95m' "${*}"; }
echo_error() { printf '%berror:\t%b\033[0m' '\033[31m' "${*}"; }

#--------------------------------------------------
# You do not need to worry about anything that's
# placed after this line. ;-)
#--------------------------------------------------

## Print this help (default)
help() {
    printf '\033[0m\n%b%64s\033[0m\n%b %-63s\033[0m\n%b%64s\033[0m\n\n' '\033[1;104;97m' '' '\033[1;104;97m' 'TangoMan CI Manager' '\033[1;104;97m' '';

    printf '\033[33mInfos:\n'
    printf '\033[32m  author  \033[97m"Matthias Morin" <mat@tangoman.io> \n'
    printf '\033[32m  license \033[97mMIT \n'
    printf '\033[32m  version \033[97m2.4.1-light \n'
    printf '\033[32m  link    \033[97mhttps://github.com/TangoMan75/entrypoint \n\n'

    printf '\033[33mDescription:\n'
    printf '\033[97m  Run Continuous Integration   \n\n'

    printf '\033[33mUsage:\n'
    printf '\033[95m  sh entrypoint.sh [\033[32mcommand\033[95m] \n\n'
    printf '\033[33mCommands:\n'
    printf '\033[32m  hooks   \033[97mInstall git hooks\n'
    printf '\033[32m  lint    \033[97mSniff errors with linter\n'
    printf '\033[32m  help    \033[97mPrint this help (default)\n'
}

#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _execute=''
    for _argument in "$@"; do
        _is_valid=false
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(echo "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        if [ "${_is_valid}" = false ]; then
            printf '\033[1;31merror:\t\033[0;91m"%s" is not a valid command\033[0m\n' "${_argument}"
            help
            exit 1
        fi
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
