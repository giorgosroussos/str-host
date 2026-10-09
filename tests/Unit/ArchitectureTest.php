<?php

// specs/02-architecture.md §1, D-026: the money calculation lives only in app/Money and
// is callable without a database, so it may not reach for the framework or the models.
arch('app/Money is pure: no framework, no models, no database')
    ->expect('App\Money')
    ->not->toUse(['Illuminate', 'App\Models', 'PDO']);

arch('no debugging statements are left in the application')
    ->expect(['dd', 'dump', 'ray', 'var_dump', 'print_r'])
    ->not->toBeUsed();
