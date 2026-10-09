#!/usr/bin/env bash
# Fails fast, with the fix, when a tool the command contract needs is missing or too old.
# Called by `make setup` and by every target that runs Node (FND-01).
set -euo pipefail

fail() { echo "toolchain: $*" >&2; exit 1; }

version_ge() { # version_ge HAVE NEED
    [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

need_php=8.3.0
need_node=$(sed -n 's/.*"node": *">=\([0-9.]*\)".*/\1/p' package.json)

command -v php >/dev/null || fail "php not found; PHP ${need_php}+ is required (specs/02-architecture.md §2)."
have_php=$(php -r 'echo PHP_VERSION;')
version_ge "$have_php" "$need_php" || fail "PHP ${need_php}+ required, found ${have_php}."

command -v composer >/dev/null || fail "composer not found."

command -v node >/dev/null || fail "node not found; Node ${need_node}+ is required (see .nvmrc: run 'nvm use')."
have_node=$(node -p 'process.versions.node')
version_ge "$have_node" "$need_node" \
    || fail "Node ${need_node}+ required, found ${have_node}. Run 'nvm use' (the repository pins .nvmrc) or put a newer node first on PATH."

if [ "${1:-}" = "--with-docker" ]; then
    command -v docker >/dev/null || fail "docker not found; local PostgreSQL 16 runs under Docker Compose (specs/11-infrastructure-operations.md §1)."
    docker compose version >/dev/null 2>&1 || fail "the docker compose plugin is required."
fi
