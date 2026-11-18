#!/bin/bash

ROOT_DIR="$PWD"
export ROOT_DIR

GALE_CONFIG=build.config.gale.standalone
DEW_CONFIG=build.config.dew.standalone
GALE_VENDOR_CONFIG=build.config.gale.mixed

OUTDIR="$ROOT_DIR/out"

die() {
	echo "error: $*" >&2
	exit 1
}

build_gale_vendor() {

	[[ -f "$OUTDIR/dist/vmlinux.symvers" ]] || die \
		"missing $OUTDIR/dist/vmlinux.symvers; run ./build_kernel.sh gale first"

	export GKI_PREBUILTS_DIR="$OUTDIR/dist"
	BUILD_CONFIG="$GALE_VENDOR_CONFIG" OUT_DIR="$OUTDIR" \
		bash kernel_modules/scripts/legacy_build.sh "-j$(nproc)"

}

case "${1:-}" in
gale)
	shift
	mkdir -p "$OUTDIR"
	BUILD_CONFIG="$GALE_CONFIG" OUT_DIR="$OUTDIR" \
		bash kernel_modules/scripts/legacy_build.sh "-j$(nproc)"
	;;
gale-vendor)
	shift
	build_gale_vendor
	;;
dew)
	shift
	BUILD_CONFIG="$DEW_CONFIG" OUT_DIR="$OUTDIR" \
		bash kernel_modules/scripts/legacy_build.sh "-j$(nproc)"
	;;
clean)
	shift
	rm -rf out/
	clear
	echo "cleaned out/"
	;;
"")
	echo "error: specify target: run ./build_kernel.sh gale or dew" >&2
	exit 1
	;;
esac
