#!/bin/bash
set -eu

log_error(){
    logger \
        --tag "$(basename "$0")" \
        --stderr \
        --priority 'user.error' \
        "${1}"
}

if [ "${1}" != "oci" ] &&
   [ "${1}" != "docker" ]; then
    log_error "must call with either 'oci' or 'docker' as sole parameter"
    exit 1
fi

shopt -s expand_aliases
alias b=buildah

container=$(buildah from docker://ubuntu:16.04)
log_error "created working container ${container}"
b run "${container}" -- \
        "apt update \
    && apt install --yes --no-install-recommends toilet \
    && rm -rf /var/lib/apt/lists/*"
b copy "${container}" "./files/it-works.txt" '/etc/toilet-banner.txt'
b run "${container}" -- "bash -c cat /etc/toilet-banner.txt"
b config \
  --cmd '/usr/bin/toilet --metal' \
  --entrypoint '/usr/bin/toilet' \
  "${container}"

b commit \
  --format "${1}" \
  --rm \
  "${container}" "buildah-demo-${1}"
