#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Yaml
##
## A light tool to roughly parse yaml files from shell scripts
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

## Read parameter from .yaml file
get_parameter() {
    local ARGUMENTS=()
    local FILE_PATH
    local PARAMETER
    local SEPARATOR=':'

    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :f:s:h OPTION; do
            case "${OPTION}" in
                f) FILE_PATH="${OPTARG}";;
                s) SEPARATOR="$(echo "${OPTARG}"|sed -E 's/^[[:space:]]*//'|sed -E 's/[[:space:]]*$//'|tr -d "\t")";;
                h) _echo_warning 'get_parameter'
                    _echo_success 'description:' 2 14; _echo_primary 'Return parameter value from given yml file\n'
                    _echo_success 'usage' 2 14; _echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)\n'
                    return 0;;
                :) _echo_danger "error: \"${OPTARG}\" requires value\n"
                    return 1;;
                \?) _echo_danger "error: invalid option \"${OPTARG}\"\n"
                    return 1;;
            esac
        done
        if [ "${OPTIND}" -gt 1 ]; then
            shift $(( OPTIND-1 ))
        fi
        if [ "${OPTIND}" -eq 1 ]; then
            ARGUMENTS+=("${1}")
            shift
        fi
    done

    if [ "${#ARGUMENTS[@]}" -eq 0 ]; then
        _echo_danger 'error: some mandatory parameter is missing\n' 2
        _echo_success 'usage' 2 7; _echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)\n'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        _echo_danger "error: too many arguments (${#ARGUMENTS[@]})\n" 2
        _echo_success 'usage' 2 7; _echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)\n'
        return 1
    fi

    # check file exists
    if [ ! -f "${FILE_PATH}" ]; then
        _echo_danger "error: Could not find \"${FILE_PATH}\"\n"
        return 1
    fi

    PARAMETER="${ARGUMENTS[0]}"

    # 1. `grep -v '#'`: ignore comments
    # 2. `grep -m1`:    return first match only
    # 3. `sed`:         remove parameter from match
    # 4. trim leading and trailing whitespaces and remove all tabulations
    # sed -E 's/^[[:space:]]*//' | sed -E 's/[[:space:]]*$//' | tr -d "\t"
    < "${FILE_PATH}" grep -v '#' | grep -E -m1 "^\s*${PARAMETER}\s*${SEPARATOR}" | sed "s/${PARAMETER}${SEPARATOR}//g" | sed -E 's/^[[:space:]]*//' | sed -E 's/[[:space:]]*$//' | tr -d "\t"
}
