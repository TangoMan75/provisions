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
src_file="../src/git/get_latest_release.sh"

# shellcheck source=/dev/null
. "${src_file}"
# shellcheck source=/dev/null
. "${parent_directory}/src/colors/colors.sh"

test_script_execution_should_return_expected_status_code() {
    assert_status_code 0 "${src_file}"
}

test_get_latest_release_missing_arguments_should_return_expected_error() {
    assert_fails "$(get_latest_release)"
}

setup() {
    # create a stub curl executable (shell functions fail the [ -x ] check in get_latest_release)
    STUB_DIR=$(mktemp -d)
    cat > "${STUB_DIR}/curl" <<'EOF'
#!/bin/bash
if [ -n "${FAKE_CURL_TAG:-}" ]; then
    printf '{"tag_name": "%s"}' "${FAKE_CURL_TAG}"
fi
EOF
    chmod +x "${STUB_DIR}/curl"
    PATH="${STUB_DIR}:${PATH}"
}

teardown() {
    rm -rf "${STUB_DIR}"
    unset FAKE_CURL_TAG
}

test_get_latest_release_should_strip_version_prefix() {
    export FAKE_CURL_TAG=version26.3.0
    assert_equals "26.3.0" "$(get_latest_release owner/repository)"
}

test_get_latest_release_should_strip_v_prefix() {
    export FAKE_CURL_TAG=v1.2.3
    assert_equals "1.2.3" "$(get_latest_release owner/repository)"
}

test_get_latest_release_should_return_plain_tag() {
    export FAKE_CURL_TAG=1.2.3
    assert_equals "1.2.3" "$(get_latest_release owner/repository)"
}
