# STR Host root command contract (AGENTS.md "Commands").
#
# `check-docs`, `check-locks`, `verify-chain`, the two `rebuild-*` targets,
# `install-hooks` and `unlock` are real from the first commit; FND-01 made every
# other target real. Helpers live in scripts/. The target list itself is the
# contract and does not change without a DECISIONS.md entry (D-001).
#
# Prerequisites: PHP 8.3, Composer, Node (version in .nvmrc and package.json
# "engines"), Docker with the Compose plugin, Python 3. `make test`,
# `make test-browser`, `make migrate` and `make dev` need `make infra-up` first.

SHELL := /bin/bash
.DEFAULT_GOAL := help

PHP_TEST_SUITES := Unit,Feature,Isolation
PRETTIER_PATHS := resources/js resources/css vite.config.ts eslint.config.js tsconfig.json .prettierrc.json

.PHONY: help setup infra-up infra-status infra-down migrate dev test test-browser lint format format-check typecheck build verify smoke audit scan-secrets check-docs check-locks verify-chain rebuild-decisions rebuild-questions install-hooks unlock clean-start

help: ## List targets
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-16s %s\n", $$1, $$2}'

setup: ## Install dependencies from lockfiles, copy env examples
	scripts/toolchain.sh --with-docker
	composer install --no-interaction --prefer-dist --no-progress
	npm ci --no-audit --no-fund
	@if [ ! -f .env ]; then cp .env.example .env && echo "setup: created .env from .env.example"; fi
	@if ! grep -qE '^APP_KEY=.+' .env; then php artisan key:generate --ansi; fi
	npx playwright install chromium

infra-up: ## Start local infrastructure and wait for health
	docker compose up --detach --wait

infra-status: ## Show infrastructure status
	docker compose ps --all

infra-down: ## Stop local infrastructure (data kept)
	docker compose down

migrate: ## Apply database migrations locally
	php artisan migrate --no-interaction

dev: ## Run every application process for local development
	scripts/toolchain.sh
	scripts/dev.sh

test: ## All automated tests against the real database engine
	php artisan config:clear --no-interaction >/dev/null
	php vendor/bin/pest --testsuite=$(PHP_TEST_SUITES)

test-browser: ## Browser tests of the critical journeys, with accessibility checks
	scripts/toolchain.sh
	npm run build
	php vendor/bin/pest --testsuite=Browser

lint: ## Linters
	scripts/toolchain.sh
	php vendor/bin/phpstan analyse --no-progress --memory-limit=1G
	npx eslint .

format: ## Apply formatting
	scripts/toolchain.sh
	php vendor/bin/pint
	npx prettier --write $(PRETTIER_PATHS)

format-check: ## Verify formatting without changing files
	scripts/toolchain.sh
	php vendor/bin/pint --test
	npx prettier --check $(PRETTIER_PATHS)

typecheck: ## Static analysis and type checks
	scripts/toolchain.sh
	npx vue-tsc --noEmit

build: ## Production builds
	scripts/toolchain.sh
	npm run build

verify: lint format-check typecheck test test-browser build check-docs ## All quality gates

smoke: ## Health of the running system through its public entry points
	scripts/smoke.sh

audit: ## Dependency advisories
	composer audit --locked --no-interaction
	npm audit

scan-secrets: ## Secret scan of everything Git tracks
	scripts/scan-secrets.sh

verify-chain: ## Recompute every hash and link in the event log
	python3 scripts/verify-chain.py

rebuild-decisions: ## Render DECISIONS.md from the event log's decisions stream
	python3 scripts/rebuild-decisions.py

rebuild-questions: ## Render QUESTIONS.md from the event log's questions stream
	python3 scripts/rebuild-questions.py

# `rebuild-decisions` is deliberately NOT a prerequisite of check-docs: it would
# repair a drifted projection instead of failing on it, which is the opposite of
# what the gate is for. check-docs rebuilds into a buffer and compares.
check-docs: verify-chain ## Mechanical consistency of the documentation layer
	python3 scripts/check-docs.py

check-locks: ## Lock manifest check of the staged change (what the pre-commit hook runs)
	python3 scripts/lock-guard.py --staged

install-hooks: ## Point git at the versioned hooks in .githooks/ and re-apply read-only modes (once per clone)
	git config core.hooksPath .githooks
	chmod +x .githooks/pre-commit .githooks/post-commit .githooks/pre-receive
	python3 scripts/lock-guard.py --relock
	@echo "hooks active from $$(git config core.hooksPath). The remote needs .githooks/pre-receive installed separately; see .githooks/README.md."

unlock: ## Ceremonial unlock of one hard-locked path: make unlock PATH=<path> REASON="why"
	@target='$(or $(TARGET),$(PATH))'; \
	 case "$$target" in *:*) target='' ;; esac; \
	 PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'; export PATH; \
	 sh scripts/unlock.sh "$$target" "$(REASON)"

clean-start: ## Fresh isolated environment: setup, infra-up, migrate, verify, smoke, teardown
	scripts/clean-start.sh
