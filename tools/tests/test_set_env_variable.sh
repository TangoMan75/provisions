#!/bin/bash

#/*
## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

# https://github.com/pgrange/bash_unit
#
#     assert "test -e /tmp/the_file"
#     assert_fails "grep this /tmp/the_file" "should not write 'this' in /tmp/the_file"
#     assert_status_code 25 code
#     assert_equals "a string" "another string" "a string should be another string"
#     assert_not_equals "a string" "a string" "a string should be different from another string"
#     fake ps echo hello world

fixtures_directory="$(pwd)/fixtures"
parent_directory="$(dirname "$(pwd)")"
src_file="../src/env/set_variable.sh"
# shellcheck source=/dev/null
. "${src_file}"
# shellcheck source=/dev/null
. "${parent_directory}/src/colors/colors.sh"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test_set_env_variable_should_replace_active_value() {
    local file
    file=$(mktemp)
    cp "${fixtures_directory}/fixture.env" "${file}"

    set_env_variable 'OPENCODE_SERVER_VERSION' 'v2' "${file}"

    assert_equals 'v2' "$(grep '^OPENCODE_SERVER_VERSION=' "${file}" | cut -d= -f2)"
    rm -f "${file}"
}

test_set_env_variable_should_uncomment_value() {
    local file
    file=$(mktemp)
    cp "${fixtures_directory}/fixture.env" "${file}"

    set_env_variable 'OPENCODE_API_URL' 'http://127.0.0.1:49374' "${file}"

    assert_equals 'http://127.0.0.1:49374' "$(grep '^OPENCODE_API_URL=' "${file}" | cut -d= -f2-)"
    rm -f "${file}"
}

test_set_env_variable_should_append_missing_value() {
    local file
    file=$(mktemp)
    cp "${fixtures_directory}/fixture.env" "${file}"

    set_env_variable 'OPENCODE_SERVER_USERNAME' 'opencode' "${file}"

    assert_equals 'opencode' "$(grep '^OPENCODE_SERVER_USERNAME=' "${file}" | cut -d= -f2)"
    rm -f "${file}"
}

test_set_env_variable_should_fail_when_file_is_missing() {
    assert_fails "set_env_variable 'KEY' 'value' '/tmp/tangoman-provisions-missing.env'"
}
