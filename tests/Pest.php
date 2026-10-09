<?php

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/*
| Test layers (specs/12-testing-acceptance.md §1, D-026, D-036):
|   tests/Unit       pure code, including every money rule; no application, no database
|   tests/Feature    HTTP flows against PostgreSQL 16
|   tests/Isolation  tenant and owner isolation, against PostgreSQL 16 (ACC-01 onward)
|   tests/Browser    critical journeys in a real browser, each page checked with axe
*/

// HTTP-level tests do not need built assets, so `make test` runs before `make build`
// in a fresh clone. Browser tests load the real bundle (`make test-browser` builds it).
pest()->extend(TestCase::class)
    ->use(RefreshDatabase::class)
    ->beforeEach(fn () => $this->withoutVite())
    ->in('Feature', 'Isolation');

pest()->extend(TestCase::class)
    ->use(RefreshDatabase::class)
    ->in('Browser');
