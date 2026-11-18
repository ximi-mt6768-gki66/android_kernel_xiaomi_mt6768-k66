#!/bin/bash
# xiaomi dew build script
# Usage:
#   ./build_dew.sh                 # ThinLTO, production-like
#   LTO=none ./build_dew.sh        # much faster incremental/dev build
#   OUT_DIR=/path ./build_dew.sh
#
# The resulting kernel image and modules are placed in:
#   ${OUT_DIR}/kernel-6.6/dist/
set -e

cd "$(dirname "$(readlink -f "$0")")"

export ROOT_DIR="$PWD"
export OUT_DIR="${OUT_DIR:-$PWD/out}"
export BUILD_CONFIG="${BUILD_CONFIG:-build.config.dew.standalone}"

exec bash kernel_modules/scripts/legacy_build.sh "$@"
