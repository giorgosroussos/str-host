#!/usr/bin/env bash
# `make smoke`: health of the running system through its public entry points (FND-01).
# Run it against the processes `make dev` starts (or any deployment, via APP_URL).
#   1. GET /up       the application answers and reaches PostgreSQL
#   2. GET /         the Inertia page renders through the web middleware stack
#   3. Vite client   when the dev server is running (public/hot), it serves assets
set -euo pipefail

base=$(scripts/env-value.sh APP_URL http://127.0.0.1:8000)
base=${base%/}
fail() { echo "smoke: FAIL $*" >&2; exit 1; }

health=$(curl -fsS --max-time 10 "${base}/up") || fail "${base}/up did not answer 2xx"
case "$health" in
    *'"status":"up"'*'"database":"up"'*) echo "smoke: ok   ${base}/up -> ${health}" ;;
    *) fail "${base}/up answered ${health}" ;;
esac

home=$(curl -fsS --max-time 10 "${base}/") || fail "${base}/ did not answer 2xx"
case "$home" in
    *'data-page'*'Home'*|*'"component":"Home"'*) echo "smoke: ok   ${base}/ renders the Inertia page" ;;
    *) fail "${base}/ did not render the Inertia page" ;;
esac

if [ -f public/hot ]; then
    vite=$(tr -d '[:space:]' < public/hot)
    curl -fsS --max-time 10 -o /dev/null "${vite}/@vite/client" || fail "Vite dev server ${vite} does not serve its client"
    echo "smoke: ok   ${vite} serves the Vite client"
fi

echo "smoke: passed"
