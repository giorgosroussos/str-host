#!/usr/bin/env bash
# `make scan-secrets`: secret scan of everything Git tracks (FND-01).
# Copies the working-tree version of every tracked file into a scratch directory and
# scans it with gitleaks, run from its pinned container image so no binary has to be
# installed. Untracked and ignored files (.env, vendor/, node_modules/) are not scanned:
# they never reach the remote.
set -euo pipefail

image=${GITLEAKS_IMAGE:-ghcr.io/gitleaks/gitleaks:v8.30.1@sha256:c00b6bd0aeb3071cbcb79009cb16a60dd9e0a7c60e2be9ab65d25e6bc8abbb7f}

scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT

git ls-files -z | tar --null --files-from=- --ignore-failed-read -cf - 2>/dev/null | tar -xf - -C "$scratch"
count=$(git ls-files | wc -l)

config=()
if [ -f .gitleaks.toml ]; then
    cp .gitleaks.toml "$scratch/.gitleaks.toml"
    config=(--config /scan/.gitleaks.toml)
fi

echo "scan-secrets: scanning ${count} tracked file(s) with ${image}"
docker run --rm -v "$scratch:/scan:ro" "$image" dir /scan "${config[@]}" --redact --no-banner --exit-code 1
