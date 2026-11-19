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

## Prompt user for parameter
function prompt_user() {
    local ARGUMENTS=()
    local PARAMETER
    local BOOLEAN=false
    local YES_NO=false

    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :d:byh OPTION; do
            case "${OPTION}" in
                d) DEFAULT_VALUE="${OPTARG}";;
                b) BOOLEAN=true;;
                y) YES_NO=true;;
                h) _echo_warning 'promt_user'
                    _echo_success 'description:' 2 14; _echo_primary 'Prompt user for parameter value\n'
                    _echo_success 'usage' 2 14; _echo_primary 'promt_user [parameter] -b (boolean) -y (yes no) -d [default_value] -h (help)\n'
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
        _echo_success 'usage' 2 7; _echo_primary 'promt_user [parameter] -b (boolean) -y (yes no) -d [default_value] -h (help)\n'
        return 1
    fi

    if [ "${#ARGUMENTS[@]}" -gt 1 ]; then
        _echo_danger "error: too many arguments (${#ARGUMENTS[@]})\n" 2
        _echo_success 'usage' 2 7; _echo_primary 'promt_user [parameter] -d [default_value] -h (help)\n'
        return 1
    fi

    PARAMETER="${ARGUMENTS[0]}"

    if [ "${BOOLEAN}" == true ]; then
        if [ -n "${DEFAULT_VALUE}" ]; then
            read -rp "${PARAMETER} (true/false) [${DEFAULT_VALUE}]: " NEW_VALUE
            if [[ "${NEW_VALUE}" =~ ^[Tt][Rr]?[Uu]?[Ee]?$  ]]; then
                echo true
            elif [[ "${NEW_VALUE}" =~ ^[Ff][Aa]?[Ll]?[Ss]?[Ee]?$  ]]; then
                echo false
            else
                echo "${DEFAULT_VALUE}"
            fi
        else
            read -rp "${PARAMETER}: (true/false) [false]" NEW_VALUE
            if [[ "${NEW_VALUE}" =~ ^[Tt][Rr]?[Uu]?[Ee]?$  ]]; then
                echo true
            else
                echo false
            fi
        fi
        return 0
    fi

    if [ "${YES_NO}" == true ]; then
        if [ -n "${DEFAULT_VALUE}" ]; then
            read -rp "${PARAMETER} (yes/no) [${DEFAULT_VALUE}]: " NEW_VALUE
            if [[ "${NEW_VALUE}" =~ ^[Yy][Ee]?[Ss]?$  ]]; then
                echo 'yes'
            elif [[ "${NEW_VALUE}" =~ ^[Nn][Oo]?$  ]]; then
                echo 'no'
            else
                echo "${DEFAULT_VALUE}"
            fi
        else
            read -rp "${PARAMETER}: (yes/no) [no]" NEW_VALUE
            if [[ "${NEW_VALUE}" =~ ^[Yy][Ee]?[Ss]?$  ]]; then
                echo 'yes'
            else
                echo 'no'
            fi
        fi
        return 0
    fi

    if [ -n "${DEFAULT_VALUE}" ]; then
        read -rp "${PARAMETER} [${DEFAULT_VALUE}]: " NEW_VALUE
        if [ -n "${NEW_VALUE}" ]; then
            echo "${NEW_VALUE}"
        else
            echo "${DEFAULT_VALUE}"
        fi
    else
        read -rp "${PARAMETER}: " NEW_VALUE
        echo "${NEW_VALUE}"
    fi
}
