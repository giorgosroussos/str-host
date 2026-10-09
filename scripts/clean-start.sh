#!/usr/bin/env bash
# `make clean-start`: proves a fresh clone boots, verifies and tears down (FND-01).
#
# Clones the committed HEAD into a scratch directory and, there, on free ports and
# under its own Compose project (so its database volume is new and nothing of the
# developer's environment is reused), runs:
#   make setup, make infra-up, make migrate, make verify, make dev (background),
#   make smoke against it, then stops everything and removes the volume and clone.
# Uncommitted changes are not part of a fresh clone and are therefore not tested.
set -euo pipefail

repo=$(git rev-parse --show-toplevel)
head=$(git -C "$repo" rev-parse HEAD)

if [ -n "$(git -C "$repo" status --porcelain --untracked-files=no)" ]; then
    echo "clean-start: note: uncommitted changes are not part of the clone; testing ${head}" >&2
fi

free_port() {
    python3 -c 'import socket; s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1]); s.close()'
}

scratch=$(mktemp -d "${TMPDIR:-/tmp}/str-host-clean-start.XXXXXX")
workdir="$scratch/str-host"
dev_pid=""

export COMPOSE_PROJECT_NAME="strhost-clean-start-$(basename "$scratch" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9-')"
export DB_PORT=$(free_port)
export APP_PORT=$(free_port)
export VITE_PORT=$(free_port)
export APP_URL="http://127.0.0.1:${APP_PORT}"

teardown() {
    local status=$?
    trap - EXIT INT TERM
    set +e
    if [ -n "$dev_pid" ] && kill -0 "$dev_pid" 2>/dev/null; then
        kill -TERM -- "-$dev_pid" 2>/dev/null
        wait "$dev_pid" 2>/dev/null
    fi
    if [ -d "$workdir" ]; then
        (cd "$workdir" && docker compose down --volumes --remove-orphans >/dev/null 2>&1)
    fi
    rm -rf "$scratch"
    if [ "$status" -eq 0 ]; then
        echo "clean-start: passed (${head}); environment torn down"
    else
        echo "clean-start: FAILED with status ${status}; environment torn down" >&2
    fi
    exit "$status"
}
trap teardown EXIT INT TERM

step() { echo; echo "=== clean-start: $* ==="; }

step "clone ${head} into ${workdir}"
git clone --quiet --no-hardlinks "$repo" "$workdir"
git -C "$workdir" checkout --quiet --detach "$head"
cd "$workdir"

echo "project=${COMPOSE_PROJECT_NAME} DB_PORT=${DB_PORT} APP_PORT=${APP_PORT} VITE_PORT=${VITE_PORT}"

step "make setup";    make setup
step "make infra-up"; make infra-up
step "make migrate";  make migrate
step "make verify";   make verify

step "make dev (background)"
setsid make dev > "$scratch/dev.log" 2>&1 &
dev_pid=$!

for _ in $(seq 1 60); do
    if curl -fsS --max-time 2 "${APP_URL}/up" >/dev/null 2>&1 && [ -f public/hot ]; then
        break
    fi
    if ! kill -0 "$dev_pid" 2>/dev/null; then
        cat "$scratch/dev.log" >&2
        echo "clean-start: make dev exited early" >&2
        exit 1
    fi
    sleep 1
done

step "make smoke"
if ! make smoke; then
    cat "$scratch/dev.log" >&2
    exit 1
fi
