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

src_file="../src/colors/colors.sh"

# shellcheck source=/dev/null
. "${src_file}"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test__echo_primary_should_return_expected_code() {
    assert_status_code 127 "$(_echo_primary foobar)"
}

test__echo_primary_should_return_expected_string() {
    assert_equals "$(printf '\033[97m%b\033[0m' foobar)" "$(_echo_primary foobar)"
}

test__echo_primary_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[97m%b\033[0m' 4 '' foobar)" "$(_echo_primary foobar 4)"
}

test__echo_primary_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[97m%-*b\033[0m' 8 foobar)" "$(_echo_primary foobar 0 8)"
}

test__echo_secondary_should_return_expected_code() {
    assert_status_code 127 "$(_echo_secondary foobar)"
}

test__echo_secondary_should_return_expected_string() {
    assert_equals "$(printf '\033[94m%b\033[0m' foobar)" "$(_echo_secondary foobar)"
}

test__echo_secondary_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[94m%b\033[0m' 4 '' foobar)" "$(_echo_secondary foobar 4)"
}

test__echo_secondary_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[94m%-*b\033[0m' 8 foobar)" "$(_echo_secondary foobar 0 8)"
}

test__echo_success_should_return_expected_code() {
    assert_status_code 127 "$(_echo_success foobar)"
}

test__echo_success_should_return_expected_string() {
    assert_equals "$(printf '\033[32m%b\033[0m' foobar)" "$(_echo_success foobar)"
}

test__echo_success_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[32m%b\033[0m' 4 '' foobar)" "$(_echo_success foobar 4)"
}

test__echo_success_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[32m%-*b\033[0m' 8 foobar)" "$(_echo_success foobar 0 8)"
}

test__echo_danger_should_return_expected_code() {
    assert_status_code 127 "$(_echo_danger foobar)"
}

test__echo_danger_should_return_expected_string() {
    assert_equals "$(printf '\033[31m%b\033[0m' foobar)" "$(_echo_danger foobar)"
}

test__echo_danger_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[31m%b\033[0m' 4 '' foobar)" "$(_echo_danger foobar 4)"
}

test__echo_danger_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[31m%-*b\033[0m' 8 foobar)" "$(_echo_danger foobar 0 8)"
}

test__echo_warning_should_return_expected_code() {
    assert_status_code 127 "$(_echo_warning foobar)"
}

test__echo_warning_should_return_expected_string() {
    assert_equals "$(printf '\033[33m%b\033[0m' foobar)" "$(_echo_warning foobar)"
}

test__echo_warning_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[33m%b\033[0m' 4 '' foobar)" "$(_echo_warning foobar 4)"
}

test__echo_warning_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[33m%-*b\033[0m' 8 foobar)" "$(_echo_warning foobar 0 8)"
}

test__echo_info_should_return_expected_code() {
    assert_status_code 127 "$(_echo_info foobar)"
}

test__echo_info_should_return_expected_string() {
    assert_equals "$(printf '\033[95m%b\033[0m' foobar)" "$(_echo_info foobar)"
}

test__echo_info_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[95m%b\033[0m' 4 '' foobar)" "$(_echo_info foobar 4)"
}

test__echo_info_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[95m%-*b\033[0m' 8 foobar)" "$(_echo_info foobar 0 8)"
}

test__echo_light_should_return_expected_code() {
    assert_status_code 127 "$(_echo_light foobar)"
}

test__echo_light_should_return_expected_string() {
    assert_equals "$(printf '\033[47;90m%b\033[0m' foobar)" "$(_echo_light foobar)"
}

test__echo_light_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[47;90m%b\033[0m' 4 '' foobar)" "$(_echo_light foobar 4)"
}

test__echo_light_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[47;90m%-*b\033[0m' 8 foobar)" "$(_echo_light foobar 0 8)"
}

test__echo_dark_should_return_expected_code() {
    assert_status_code 127 "$(_echo_dark foobar)"
}

test__echo_dark_should_return_expected_string() {
    assert_equals "$(printf '\033[40;37m%b\033[0m' foobar)" "$(_echo_dark foobar)"
}

test__echo_dark_with_indentation_should_return_expected_string() {
    assert_equals "$(printf '%*b\033[40;37m%b\033[0m' 4 '' foobar)" "$(_echo_dark foobar 4)"
}

test__echo_dark_with_padding_should_return_expected_string() {
    assert_equals "$(printf '\033[40;37m%-*b\033[0m' 8 foobar)" "$(_echo_dark foobar 0 8)"
}

test__alert_primary_should_return_expected_code() {
    assert_status_code 127 "$(_alert_primary)"
}

test__alert_primary_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[104;37m%64s\033[0m\n\033[104;37m %-63s\033[0m\n\033[104;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_primary foobar)"
}

test__alert_secondary_should_return_expected_code() {
    assert_status_code 127 "$(_alert_secondary)"
}

test__alert_secondary_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[45;37m%64s\033[0m\n\033[45;37m %-63s\033[0m\n\033[45;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_secondary foobar)"
}

test__alert_success_should_return_expected_code() {
    assert_status_code 127 "$(_alert_success)"
}

test__alert_success_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[42;30m%64s\033[0m\n\033[42;30m %-63s\033[0m\n\033[42;30m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_success foobar)"
}

test__alert_danger_should_return_expected_code() {
    assert_status_code 127 "$(_alert_danger)"
}

test__alert_danger_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\033[41;37m %-63s\033[0m\n\n" '' "foobar" '';)" "$(_alert_danger foobar)"
}

test__alert_warning_should_return_expected_code() {
    assert_status_code 127 "$(_alert_warning)"
}

test__alert_warning_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[43;30m%64s\033[0m\n\033[43;30m %-63s\033[0m\n\033[43;30m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_warning foobar)"
}

test__alert_info_should_return_expected_code() {
    assert_status_code 127 "$(_alert_info)"
}

test__alert_info_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[44;37m%64s\033[0m\n\033[44;37m %-63s\033[0m\n\033[44;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_info foobar)"
}

test__alert_light_should_return_expected_code() {
    assert_status_code 127 "$(_alert_light)"
}

test__alert_light_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[47;90m%64s\033[0m\n\033[47;90m %-63s\033[0m\n\033[47;90m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_light foobar)"
}

test__alert_dark_should_return_expected_code() {
    assert_status_code 127 "$(_alert_dark)"
}

test__alert_dark_should_return_expected_string() {
    assert_equals "$(printf "\033[0m\n\033[40;37m%64s\033[0m\n\033[40;37m %-63s\033[0m\n\033[40;37m%64s\033[0m\n\n" '' "foobar" '';)" "$(_alert_dark foobar)"
}
