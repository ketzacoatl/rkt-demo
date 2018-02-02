#!/bin/bash
set -eu

script_path="$(dirname "$(realpath --no-symlinks "$0")")"
cd "${script_path}"

buildah bud -f "${script_path}/Dockerfile" -t rkt-demo:buildah --format docker .
