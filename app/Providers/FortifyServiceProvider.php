<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Laravel\Fortify\Fortify;

/**
 * Fortify is the session authentication of the staff app and the owner portal
 * (specs/02-architecture.md §2, §4). FND-01 only installs it: no route and no
 * feature is exposed until ACC-03 delivers logins, roles and the second factor
 * (specs/07-users-authorization.md §1-§4).
 */
class FortifyServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        Fortify::ignoreRoutes();
    }
}
