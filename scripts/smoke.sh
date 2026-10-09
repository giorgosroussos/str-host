#!/usr/bin/env bash
# `make smoke`: health of the running system through its public entry points (FND-01).
# Run it against the processes `make dev` starts (or any deployment, via APP_URL).
#   1. GET /up       the application answers and reaches PostgreSQL
#   2. GET /         the Inertia page renders through the web middleware stack
#   3. Vite client   when the dev server is running (public/hot), it serves assets
#   4. Mail trap     locally, application mail lands in Mailpit (see below)
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

#   4. Mail trap     locally, a message the application sends lands in Mailpit
#                    (specs/11-infrastructure-operations.md §1); skipped for any
#                    environment that is not local or does not mail to loopback.
app_env=$(scripts/env-value.sh APP_ENV production)
mailer=$(scripts/env-value.sh MAIL_MAILER log)
mail_host=$(scripts/env-value.sh MAIL_HOST "")
if [ "$app_env" = "local" ] && [ "$mailer" = "smtp" ] && { [ "$mail_host" = "127.0.0.1" ] || [ "$mail_host" = "localhost" ]; }; then
    ui="http://127.0.0.1:$(scripts/env-value.sh MAILPIT_UI_PORT 58025)"
    subject="smoke-$(date +%s)-$$"
    php artisan tinker --no-interaction --execute "Illuminate\\Support\\Facades\\Mail::raw('smoke', fn (\$m) => \$m->to('smoke@str-host.test')->subject('${subject}'));" >/dev/null \
        || fail "the application could not send through ${mail_host}:$(scripts/env-value.sh MAIL_PORT 51025)"
    found=$(curl -fsS --max-time 10 "${ui}/api/v1/search?query=subject:${subject}") || fail "Mailpit API ${ui} did not answer"
    case "$found" in
        *'"messages_count":1'*) echo "smoke: ok   mail sent by the application landed in the mail trap (${ui})" ;;
        *) fail "the smoke message did not reach the mail trap at ${ui}" ;;
    esac
fi

echo "smoke: passed"
