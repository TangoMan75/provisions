#!/bin/sh
set -e

#/*
# * This script is based on TangoMan Shoe Shell Microframework version 0.8.0-sm
# *
# * This file is distributed under to the MIT license.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * Permission is hereby granted, free of charge, to any person obtaining a copy
# * of this software and associated documentation files (the "Software"), to deal
# * in the Software without restriction, including without limitation the rights
# * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# * copies of the Software, and to permit persons to whom the Software is
# * furnished to do so, subject to the following conditions:
# *
# * The above copyright notice and this permission notice shall be included in all
# * copies or substantial portions of the Software.
# *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# * SOFTWARE.
# *
# * Source code is available here: https://github.com/TangoMan75/shoe
# */

#/*
# * This file is part of TangoMan Provisions package.
# *
# * Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
# *
# * This source file is subject to the MIT license that is bundled
# * with this source code in the file LICENSE.
# */

#/**
# * Config Samba
# *
# * Samba file sharing service (default service on ubuntu not NFS as one could expect)
# *
# * https://askubuntu.com/questions/888205/how-to-set-up-an-entire-hard-drive-as-a-shared-drive-in-samba
# *
# * @category servers
# * @link     https://doc.ubuntu-fr.org/samba_smb.conf
# * @author   "Matthias Morin" <mat@tangoman.io>
# * @version  0.8.0-sm
# */

#--------------------------------------------------
# Place your parameters after this line
#--------------------------------------------------

## Device name /[a-z0-9]+/
device=sda1

#--------------------------------------------------
# Place your functions after this line
#--------------------------------------------------

## Config Samba file sharing
config() {
    set_global_config
    create_share
    validate
    password
    restart
}

## Force user and force group on global config
set_global_config() {
    echo_info "sudo sed -i \"s/\[global\]/[global]\n  force user = ${USER}\n  force group = ${USER}\n/\" /etc/samba/smb.conf\n"
    sudo sed -i "s/\[global\]/[global]\n  force user = ${USER}\n  force group = ${USER}\n/" /etc/samba/smb.conf
}

## Create full hard drive share
create_share() {
    # should return a string containing mounted device path eg: /media/user/DATA
    path_name=$(lsblk -l | grep ${device} | tr -s ' ' | cut -d' ' -f7)

    sudo tee --append /etc/samba/smb.conf <<EOF

# create full hard drive share
[sda1]
  # create mask = 0755
  # guest ok = Yes
  path = ${path_name}
  read only = No
  # # restrict access to given users only
  # valid users = ${USER}
EOF
}

## Create user password
password() {
    echo_info "sudo smbpasswd -a \"${USER}\"\n"
    sudo smbpasswd -a "${USER}"
}

## Delete user
delete_user() {
    echo_info "sudo smbpasswd -x \"${USER}\"\n"
    sudo smbpasswd -x "${USER}"
}

## Restart Samba service
restart() {
    echo_info 'sudo systemctl restart smbd\n'
    sudo systemctl restart smbd
}

## Open /etc/samba/smb.conf in Sublime Text
open() {
    echo_info "sudo subl /etc/samba/smb.conf\n"
    sudo subl /etc/samba/smb.conf
}

## Validate parameters
validate() {
    echo_info 'testparm -s\n'
    testparm -s
}

#--------------------------------------------------
# Colors global variables
#--------------------------------------------------

# shellcheck disable=SC2034
{
    PRIMARY='\033[97m'; SECONDARY='\033[94m'; SUCCESS='\033[32m'; DANGER='\033[31m'; WARNING='\033[33m'; INFO='\033[95m'; LIGHT='\033[47;90m'; DARK='\033[40;37m'; DEFAULT='\033[0m'; EOL='\033[0m\n';
    ALERT_PRIMARY='\033[1;104;97m'; ALERT_SECONDARY='\033[1;45;97m'; ALERT_SUCCESS='\033[1;42;97m'; ALERT_DANGER='\033[1;41;97m'; ALERT_WARNING='\033[1;43;97m'; ALERT_INFO='\033[1;44;97m'; ALERT_LIGHT='\033[1;47;90m'; ALERT_DARK='\033[1;40;37m';
}

#--------------------------------------------------
# A semantic set of colors functions
#--------------------------------------------------

# Synopsys: echo_* [string] (indentation) (padding)
echo_primary()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${PRIMARY}"    "$3" "$1" "${DEFAULT}"; }
echo_secondary() { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SECONDARY}"  "$3" "$1" "${DEFAULT}"; }
echo_success()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${SUCCESS}"    "$3" "$1" "${DEFAULT}"; }
echo_danger()    { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DANGER}"     "$3" "$1" "${DEFAULT}"; }
echo_warning()   { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${WARNING}"    "$3" "$1" "${DEFAULT}"; }
echo_info()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${INFO}"       "$3" "$1" "${DEFAULT}"; }
echo_light()     { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${LIGHT}"      "$3" "$1" "${DEFAULT}"; }
echo_dark()      { if [ $# -eq 1 ]; then set -- "$1" 0 0; elif [ $# -eq 2 ]; then set -- "$1" "$2" 0; fi; printf "%*b%b%-*b%b" "$2" '' "${DARK}"       "$3" "$1" "${DEFAULT}"; }

# Synopsys: alert_* [string]
alert_primary()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "$1" "${ALERT_PRIMARY}"   ''; }
alert_secondary() { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "$1" "${ALERT_SECONDARY}" ''; }
alert_success()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "$1" "${ALERT_SUCCESS}"   ''; }
alert_danger()    { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "$1" "${ALERT_DANGER}"    ''; }
alert_warning()   { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "$1" "${ALERT_WARNING}"   ''; }
alert_info()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "$1" "${ALERT_INFO}"      ''; }
alert_light()     { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_LIGHT}"     '' "${ALERT_LIGHT}"     "$1" "${ALERT_LIGHT}"     ''; }
alert_dark()      { printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DARK}"      '' "${ALERT_DARK}"      "$1" "${ALERT_DARK}"      ''; }

#--------------------------------------------------
# Self documentation
#--------------------------------------------------

### Help

## Print this help (default)
help() {
    _padding=$(_get_padding)

    _print_title       "$(_get_docbloc_title)"
    _print_infos       "${_padding}"
    _print_description "$(_get_docbloc_description)"
    _print_usage
    _print_options     "${_padding}"
    _print_commands    "${_padding}"
}

#--------------------------------------------------

_print_title() {
    printf "${EOL}${ALERT_PRIMARY}%64s${EOL}${ALERT_PRIMARY} %-63s${EOL}${ALERT_PRIMARY}%64s${EOL}\n" '' "$1" '';
}

_print_infos() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bInfos:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'author'  "$(_get_docbloc 'author')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'version' "$(_get_docbloc 'version')"
    printf "${SUCCESS}  %-$1s ${DEFAULT}%s\n" 'link'    "$(_get_docbloc 'link')"
    printf '\n'
}

_print_description() {
    printf "%bDescription:%b\n" "${WARNING}" "${DEFAULT}"
    printf "\033[97m  %s${EOL}\n" "$(printf '%s' "$1" | fold -w 64 -s)"
}

_print_usage() {
    printf "%bUsage:%b\n" "${WARNING}" "${DEFAULT}"
    printf "${INFO}  sh %s${INFO} [${SUCCESS}command${INFO}]${DEFAULT} " "$(basename "${0}")"
    awk -F '=' "/^[a-zA-Z0-9_]+=.+\$/ {
        if (substr(PREV, 1, 3) == \"## \" && \$1 != toupper(\$1) && substr(\$0, 1, 1) != \"_\")
        printf \"${INFO}(${SUCCESS}--%s ${WARNING}%s${INFO})${DEFAULT} \", \$1, \$2
    } { PREV = \$0 }" "$0"
    printf '\n\n'
}

_print_options() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bOptions:%b\n" "${WARNING}" "${DEFAULT}"
    awk -F '=' "/^[a-zA-Z0-9_]+=.+\$/ {
        if (substr(PREV, 1, 3) == \"## \" && \$1 != toupper(\$1) && substr(\$0, 1, 1) != \"_\") {
            if (match(PREV, / \/.+\//)) {
                CONSTRAINT=substr(PREV, RSTART, RLENGTH);
                ANNOTATION=substr(PREV, 4, length(PREV)-length(CONSTRAINT)-3);
                printf \"${SUCCESS}  --%-$1s ${DEFAULT}%s${SUCCESS}%s${INFO} (default: ${WARNING}%s${INFO})${EOL}\", \$1, ANNOTATION, CONSTRAINT, \$2
            } else {
                printf \"${SUCCESS}  --%-$1s ${DEFAULT}%s${INFO} (default: ${WARNING}%s${INFO})${EOL}\", \$1, substr(PREV, 4), \$2
            }
        }
    } { PREV = \$0 }" "$0"
    printf '\n'
}

_print_commands() {
    # $1 = padding
    if [ -z "$1" ]; then set -- 12; fi
    printf "%bCommands:%b\n" "${WARNING}" "${DEFAULT}"
    awk "/^### /{printf\"\n${WARNING}%s:${EOL}\",substr(\$0,5)}
        /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub(\"^function \",\"\"); gsub(\"[ ()]\",\"\");
        FUNCTION = substr(\$0, 1, index(\$0, \"{\"));
        sub(\"{\$\", \"\", FUNCTION);
        if (substr(PREV, 1, 3) == \"## \" && substr(\$0, 1, 1) != \"_\")
        printf \"${SUCCESS}  %-$(($1+2))s ${DEFAULT}%s\n\", FUNCTION, substr(PREV, 4)
    } { PREV = \$0 }" "$0"
    printf '\n'
}

#--------------------------------------------------
# Docbloc parsing
#--------------------------------------------------

_get_docbloc_title() {
    awk '/^#\/\*\*$/,/^# \*\/$/{i+=1; if (i==2) print substr($0, 5)}' "$0"
}

_get_docbloc_description() {
    awk '/^# \* @/ {i=2} /^#\/\*\*$/,/^# \*\/$/{i+=1; if (i>3) printf "%s ", substr($0, 5)}' "$0"
}

_get_docbloc() {
    awk -v TAG="$1" '/^#\/\*\*$/,/^# \*\/$/{if($3=="@"TAG){for(i=4;i<=NF;++i){printf "%s ",$i}}}' "$0"
}

_get_padding() {
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ { MATCH = $1 }
    /^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");
        MATCH = substr($0, 1, index($0, "{"));
        sub("{$", "", MATCH);
    } { if (substr(PREV, 1, 3) == "## " && substr(MATCH, 1, 1) != "_" && length(MATCH) > LENGTH) LENGTH = length(MATCH) }
    { PREV = $0 } END { print LENGTH+1 }' "$0"
}

#--------------------------------------------------
# Core
#--------------------------------------------------

_get_functions() {
    # this regular expression matches functions with either bash or sh syntax
    awk '/^(function )? *[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");   # remove leading "function ", round brackets and extra spaces
        FUNCTION = substr($0, 1, index($0, "{")); # truncate string after opening curly brace
        sub("{$", "", FUNCTION);                  # remove trailing curly brace
        if (substr(PREV, 1, 3) == "## " && substr($0, 1, 1) != "_") print FUNCTION
    } { PREV = $0 }' "$0"
}

_get_variables() {
    # constants and private variables will be ignored
    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV, 1, 3) == "## " && $1 != toupper($1) && substr($0, 1, 1) != "_")print $1
    } { PREV = $0 }' "$0"
}

#--------------------------------------------------
# Validation
#--------------------------------------------------

_get_constraints() {
    awk -v NAME="$1" -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV, 1, 3) == "## " && $1 == NAME) {match(PREV, /\/.+\//); print substr(PREV, RSTART, RLENGTH)}
    } { PREV = $0 }' "$0"
}

_validate() {
    _validate_variable=$(printf '%s' "$1" | cut -d= -f1)
    _validate_value=$(printf '%s' "$1" | cut -d= -f2)
    _validate_pattern=$(_get_constraints "${_validate_variable}")
    if [ -z "${_validate_pattern}" ]; then
        return 0
    fi
    if [ "${_validate_value}" != "$(printf '%s' "${_validate_value}" | awk "match(\$0, ${_validate_pattern}) {print substr(\$0, RSTART, RLENGTH)}")" ]; then
        printf "${DANGER}error: invalid \"%s\", expected \"%s\", \"%s\" given${EOL}" "${_validate_variable}" "${_validate_pattern}" "${_validate_value}"
        exit 1
    fi
}

#--------------------------------------------------
# Main loop
#--------------------------------------------------

_main() {
    if [ $# -lt 1 ]; then
        help
        exit 0
    fi

    _error=''
    _eval=''
    _execute=''
    _requires_value=''
    for _argument in "$@"; do
        _is_valid=false
        # check if previous argument requires value
        if [ -n "${_requires_value}" ]; then
            _eval="${_eval} ${_requires_value}=${_argument}"
            _requires_value=''
            continue
        fi
        # check argument is a valid option (must start with - or --)
        if [ -n "$(printf '%s' "${_argument}" | awk '/^--?[a-zA-Z0-9_]+$/{print}')" ]; then
            for _variable in $(_get_variables); do
                # get shorthand character
                _shorthand="$(printf '%s' "${_variable}" | awk '{$0=substr($0, 1, 1); print}')"
                if [ "${_argument}" = "--${_variable}" ] || [ "${_argument}" = "-${_shorthand}" ]; then
                    _requires_value="${_variable}"
                    _is_valid=true
                    break
                fi
            done
            if [ "${_is_valid}" = false ]; then
                _error="\"${_argument}\" is not a valid option"
                break
            fi
            continue
        fi
        for _function in $(_get_functions); do
            # get shorthand character
            _shorthand="$(printf '%s' "${_function}" | awk '{$0=substr($0, 1, 1); print}')"
            if [ "${_argument}" = "${_function}" ] || [ "${_argument}" = "${_shorthand}" ]; then
                # append argument to the execute stack
                _execute="${_execute} ${_function}"
                _is_valid=true
                break
            fi
        done
        if [ "${_is_valid}" = false ]; then
            _error="\"${_argument}\" is not a valid command"
            break
        fi
    done

    if [ -n "${_requires_value}" ]; then
        _error="\"--${_requires_value}\" requires value"
    fi

    if [ -n "${_error}" ]; then
        printf "${DANGER}error: %s${EOL}" "${_error}"
        exit 1
    fi

    for _variable in ${_eval}; do
        # invalid parameters will raise errors
        _validate "${_variable}"
        eval "${_variable}"
    done

    for _function in ${_execute}; do
        eval "${_function}"
    done
}

_main "$@"
