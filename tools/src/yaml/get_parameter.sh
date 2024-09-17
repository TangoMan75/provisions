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
# * TangoMan Yaml
# *
# * A light tool to roughly parse yaml files from shell scripts
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

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
                h) echo_warning 'get_parameter'
                    echo_label 'description:'; echo_primary 'Return parameter value from given yml file'
                    echo_label 'usage'; echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)'
                    return 0;;
                :) echo_error "\"${OPTARG}\" requires value"
                    return 1;;
                \?) echo_error "invalid option \"${OPTARG}\""
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
        echo_error 'some mandatory parameter is missing'
        echo_label 'usage'; echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        echo_error "too many arguments (${#ARGUMENTS[@]})"
        echo_label 'usage'; echo_primary 'get_parameter [parameter] -f [file_path] -s [separator] -h (help)'
        return 1
    fi

    # check file exists
    if [ ! -f "${FILE_PATH}" ]; then
        echo_error "Could not find \"${FILE_PATH}\""
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
