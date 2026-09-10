#!/usr/bin/env bash
set -euo pipefail

# Clean only artifacts that belong to this synthesis directory, even when this
# script is invoked from another working directory.
synthesis_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

rm -rf -- \
    "$synthesis_dir"/genus.log* \
    "$synthesis_dir"/genus.cmd* \
    "$synthesis_dir"/outputs \
    "$synthesis_dir"/reports \
    "$synthesis_dir"/test_scripts \
    "$synthesis_dir"/fv
