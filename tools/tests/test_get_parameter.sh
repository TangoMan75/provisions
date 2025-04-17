#!/bin/bash

#/*
## This file is part of TangoMan Bash Tools package.
##
## Copyright (c) 2023 "Matthias Morin" <mat@tangoman.io>
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
src_file="../src/yaml/get_parameter.sh"

# shellcheck source=/dev/null
. "${src_file}"
# shellcheck source=/dev/null
. "${parent_directory}/src/colors/colors.sh"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test_get_parameter_should_return_expected_result() {
    assert_equals 'bar' "$(get_parameter foo -f "${fixtures_directory}/fixture.yaml")"
}
