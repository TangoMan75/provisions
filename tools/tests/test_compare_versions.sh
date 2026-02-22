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

parent_directory="$(dirname "$(pwd)")"
src_file="../src/system/compare_versions.sh"

# shellcheck source=/dev/null
. "${src_file}"
# shellcheck source=/dev/null
. "${parent_directory}/src/colors/colors.sh"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test_missing_arguments_should_return_expected_error() {
    assert_fails "$(compare_versions)"
}

test_empty_arguments_should_return_expected_error() {
    assert_fails "$(compare_versions '' '')"
}

test_invalid_argument_should_return_expected_error() {
    assert_fails "$(compare_versions foobar 1.0.0)"
}

test_invalid_second_argument_should_return_expected_error() {
    assert_fails "$(compare_versions 1.0.0 foobar)"
}

test_missing_second_argument_should_return_expected_error() {
    assert_fails "$(compare_versions 0.1.0)"
}

test_empty_second_argument_should_return_expected_error() {
    assert_fails "$(compare_versions 0.1.0 '')"
}

test_compare_versions_should_return_equal() {
    assert_equals '=' "$(compare_versions 0.1.0 0.1.0)"
}

test_check_major_version_should_return_lower_than() {
    assert_equals '<' "$(compare_versions 1.0.0 2.0.0)"
}

test_check_major_version_should_return_greater_than() {
    assert_equals '>' "$(compare_versions 2.0.0 1.0.0)"
}

test_check_minor_version_should_return_lower_than() {
    # shellcheck disable=SC2317
    assert_equals '<' "$(compare_versions 2.0.0 2.1.0)"
}

test_check_minor_version_should_return_greater_than() {
    # shellcheck disable=SC2317
    assert_equals '>' "$(compare_versions 2.1.0 2.0.0)"
}

test_check_minor_version_should_return_greater_than_alt() {
    # shellcheck disable=SC2317
    assert_equals '>' "$(compare_versions 2.1.0 2.0.1)"
}

test_check_minor_version_should_return_lower_than() {
    assert_equals '<' "$(compare_versions 2.0.0 2.1.0)"
}

test_check_minor_version_should_return_lower_than_alt() {
    assert_equals '<' "$(compare_versions 2.0.1 2.1.0)"
}

test_check_minor_version_should_return_greater_than() {
    assert_equals '>' "$(compare_versions 2.1.0 2.0.0)"
}

test_check_minor_version_should_return_greater_than_alt() {
    assert_equals '>' "$(compare_versions 2.1.0 2.0.1)"
}

test_check_patch_version_should_return_lower_than() {
    assert_equals '<' "$(compare_versions 2.0.0 2.1.0)"
}

test_check_patch_version_should_return_lower_than_alt() {
    assert_equals '<' "$(compare_versions 2.0.1 2.1.0)"
}

test_check_patch_version_should_return_greater_than() {
    assert_equals '>' "$(compare_versions 2.1.0 2.0.0)"
}

test_check_patch_version_should_return_greater_than_alt() {
    assert_equals '>' "$(compare_versions 2.1.0 2.0.1)"
}

