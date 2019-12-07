#!/bin/bash

# Bash Strict Mode # For scripts that already depend on Bash.
set -eu -o pipefail
IFS=$'\n\t'

D_SCRIPT="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd -P)"
BASE_URL='https://downloads.yoctoproject.org/releases/yocto'
DEFAULT_CSVFILE="data/yocto-releases.csv"

cd "${D_SCRIPT}/../"
CSVFILE="${1-"${DEFAULT_CSVFILE}"}"

datalad addurls \
    --ifexists 'overwrite' \
    "${CSVFILE}" \
    "${BASE_URL}/yocto-{version}/{relpath}" \
    "files/yocto-{version}/{relpath}"

