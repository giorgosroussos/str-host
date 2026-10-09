#!/usr/bin/env bash
# Prints a setting the way the application sees it: the shell environment first,
# then .env, then the given default. Usage: scripts/env-value.sh NAME [DEFAULT]
set -euo pipefail

name=$1
default=${2:-}

if [ -n "${!name:-}" ]; then
    printf '%s\n' "${!name}"
    exit 0
fi

if [ -f .env ]; then
    line=$(grep -E "^${name}=" .env | tail -n1 || true)
    if [ -n "$line" ]; then
        value=${line#*=}
        value=${value%\"}
        value=${value#\"}
        printf '%s\n' "$value"
        exit 0
    fi
fi

printf '%s\n' "$default"
