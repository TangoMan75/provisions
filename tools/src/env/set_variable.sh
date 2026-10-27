#!/bin/bash

#/*
## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## TangoMan Env
##
## Set or update a variable in a dotenv file
##
## @licence MIT
## @author  "Matthias Morin" <mat@tangoman.io>

## Set variable to .env file
set_env_variable() {
    local FILE_PATH="${3}"
    local KEY="${1}"
    local VALUE="${2}"
    local ESCAPED_VALUE

    if [ -z "${KEY}" ] || [ -z "${FILE_PATH}" ]; then
        _echo_danger 'error: some mandatory parameter is missing\n'
        return 1
    fi

    if [ ! -f "${FILE_PATH}" ]; then
        _echo_danger "error: file not found: ${FILE_PATH}\n"
        return 1
    fi

    # Escape characters that are special in the replacement part of sed.
    ESCAPED_VALUE=$(printf '%s' "${VALUE}" | sed -e 's/\\/\\\\/g' -e 's/[\/&]/\\&/g')

    # Update an active variable.
    if grep -q "^${KEY}=" "${FILE_PATH}"; then
        sed -i -E "s/^${KEY}=.*/${KEY}=${ESCAPED_VALUE}/" "${FILE_PATH}"

    # Uncomment a commented variable.
    elif grep -q "^#[[:space:]]*${KEY}=" "${FILE_PATH}"; then
        sed -i -E "s/^#[[:space:]]*${KEY}=.*/${KEY}=${ESCAPED_VALUE}/" "${FILE_PATH}"

    # Append the variable when it is missing.
    else
        if [ -n "$(tail -c 1 "${FILE_PATH}")" ]; then
            printf '\n' >> "${FILE_PATH}"
        fi
        printf '%s=%s\n' "${KEY}" "${VALUE}" >> "${FILE_PATH}"
    fi

    return 0
}
