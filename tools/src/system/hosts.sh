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
# * Tangoman Hosts
# *
# * Edit hosts config from shell scripts
# *
# * @licence MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## set your /etc/hosts
function set_hosts() {
    local HOST_NAME
    local IP_ADDRESS=127.0.0.1
    local DELETE=false

    local ARGUMENTS=()
    local OPTARG
    local OPTION
    while [ "${#}" -gt 0 ]; do
        OPTIND=0
        while getopts :i:dh OPTION; do
            case "${OPTION}" in
                d) DELETE=true;;
                i) IP_ADDRESS="${OPTARG}";;
                h) echo_warning 'set_hosts'
                    echo_label 'description'; echo_primary 'Create / delete hosts in /etc/hosts'
                    echo_label 'usage'; echo_primary 'set-hosts [hosts] -i (ip) -d (delete) -h (help)'
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
        echo_label 'usage'; echo_primary 'set-hosts [hosts] -i (ip) -d (delete) -h (help)'
        return 1
    fi

    for HOST_NAME in "${ARGUMENTS[@]}"; do

        # find "hostname"
        if < /etc/hosts grep -q -P "\s+${HOST_NAME}$";then
            # remove every occurence
            # shellcheck disable=SC2002
            cat /etc/hosts | grep -vP "\s+${HOST_NAME}$" | sudo tee /etc/hosts >/dev/null

            if [ "${DELETE}" = true ];then
                echo_danger "Deleting host: \"${IP_ADDRESS}    ${HOST_NAME}\""
            else
                echo_warning "Updating host: \"${IP_ADDRESS}    ${HOST_NAME}\""
                sudo /bin/sh -c "echo \"${IP_ADDRESS}    ${HOST_NAME}\">> /etc/hosts"
            fi
        else
            if [ "${DELETE}" = true ];then
                echo_error "\"${HOST_NAME}\" not found"
            else
                echo_success "Creating host: \"${IP_ADDRESS}    ${HOST_NAME}\""
                sudo /bin/sh -c "echo \"${IP_ADDRESS}    ${HOST_NAME}\">> /etc/hosts"
            fi
        fi
    done
}
