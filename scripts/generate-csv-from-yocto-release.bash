#!/bin/bash
# Usage Examples:
#
# ./scripts/generate-csv-from-yocto-release.bash 'poky-glibc-x86_64-core-image-sato-aarch64-qemuarm64' > data/toolchain-x86_64-aarch64-qemuarm64.csv

# Bash Strict Mode # For scripts that already depend on Bash.
set -eu -o pipefail
IFS=$'\n\t'

D_SCRIPT="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"
D_BASE="${D_BASE-"${D_SCRIPT}/../"}"
DEFAULT_VERSION='3.1.1'

generate_csv_from_yocto_release(){
    local grep_arg

    grep_arg="${1?Grep arg is required}"
    version="${2-"${DEFAULT_VERSION}"}"

    f_input="${D_SCRIPT}/../files/yocto-${version}/yocto-${version}.sha256sum"
    if [ ! -f "${f_input}" ] ; then
        ( set -x ; [ ! -f "${f_input}" ] )
        return 1 # TODO: Should print to stderr.
    fi

    # csv header
    printf "%s,%s\n" \
        'version' \
        'relpath'

    # csv rows
    grep "${grep_arg}" \
        "files/yocto-${version}/yocto-${version}.sha256sum" \
        | cut -f 2 - -d ' ' \
        | sed -e "s#^#${version},#"
}

generate_csv_from_yocto_release "$@"
