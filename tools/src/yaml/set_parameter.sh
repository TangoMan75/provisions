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

## Set parameter to .yaml file
set_parameter() {
    local ARGUMENTS=()
    local FILE_PATH
    local PARAMETER
    local SEPARATOR=':'
    local SPACE=' '
    local VALUE

    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :f:s:nh OPTION; do
            case "${OPTION}" in
                f) FILE_PATH="${OPTARG}";;
                s) SEPARATOR="$(echo "${OPTARG}"|sed -E 's/^[[:space:]]*//'|sed -E 's/[[:space:]]*$//'|tr -d "\t")";;
                n) SPACE='';;
                h) _echo_warning 'set_parameter'
                   _echo_success 'description:' 2 14; _echo_primary 'Return parameter value from given yml file\n'
                   _echo_success 'usage' 2 14; _echo_primary 'set_parameter [parameter] [value] -f [file_path] -s [separator] -n (no_space) -h (help)\n'
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
        _echo_success 'usage' 2 7; _echo_primary 'set_parameter [parameter] [value] -f [file_path] -s [separator] -n (no_space) -h (help)\n'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 2 ]; then
        _echo_danger "error: too many arguments (${#ARGUMENTS[@]})\n" 2
        _echo_success 'usage' 2 7; _echo_primary 'set_parameter [parameter] [value] -f [file_path] -s [separator] -n (no_space) -h (help)\n'
        return 1
    fi

    if [ ! -f "${FILE_PATH}" ]; then
        if [ ! -f "${FILE_PATH}.dist" ]; then
            _echo_danger "error: file not found: ${FILE_PATH}\n"
            return 1
        else
            _echo_info "cp \"${FILE_PATH}.dist\" \"${FILE_PATH}\"\n"
            cp "${FILE_PATH}.dist" "${FILE_PATH}"
        fi
    fi

    PARAMETER="${ARGUMENTS[0]}"

    # shellcheck disable=SC2143
    if [ -z "$(< "${FILE_PATH}" grep -v "#" | grep "${PARAMETER}${SEPARATOR}")" ]; then
        _echo_danger "error: invalid parameter \"${PARAMETER}${SEPARATOR}\"\n"
        return 1
    fi

    # escape forward slashes if any
    VALUE=$(echo "${ARGUMENTS[1]}" | sed "s/\//\\\\\//g")
    REGEXP="${PARAMETER}${SEPARATOR}.+\$"
    sed -i -E s/"${REGEXP}/${PARAMETER}${SEPARATOR}${SPACE}${VALUE}"/ "${FILE_PATH}"
}
