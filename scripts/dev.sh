#!/usr/bin/env bash
# `make dev`: every application process for local development (FND-01).
#   web        php artisan serve on APP_PORT
#   vite       the Vite dev server on VITE_PORT (hot reload)
#   scheduler  php artisan schedule:work (specs/02-architecture.md §6)
# The database queue worker joins when the queue tables exist (see GAPS.md).
# PostgreSQL is infrastructure: start it first with `make infra-up`.
set -euo pipefail

app_port=$(scripts/env-value.sh APP_PORT 8000)
export VITE_PORT=$(scripts/env-value.sh VITE_PORT 5173)

exec npx concurrently --kill-others --names web,vite,scheduler --prefix-colors blue,magenta,yellow \
    "php artisan serve --host=127.0.0.1 --port=${app_port} --no-reload" \
    "npm run dev" \
    "php artisan schedule:work"
