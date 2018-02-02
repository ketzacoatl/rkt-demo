#!/bin/bash
set -eu

script_path="$(dirname "$(realpath --no-symlinks "$0")")"

buildah bud -f "${script_path}/Dockerfile" -t toilet:buildah --format docker .
