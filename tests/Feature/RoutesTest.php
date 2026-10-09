<?php

use Illuminate\Routing\Route;
use Illuminate\Support\Facades\Route as Router;
use Laravel\Fortify\Fortify;

// FND-01 exposes only what `make smoke` needs. Each later package that adds a route
// extends this list, so an endpoint can never appear without a test noticing.
it('registers no route beyond the scaffold page and the health probe', function () {
    $uris = collect(Router::getRoutes()->getRoutes())
        ->map(fn (Route $route) => implode('|', $route->methods()).' '.$route->uri())
        ->sort()
        ->values()
        ->all();

    expect($uris)->toBe([
        'GET|HEAD /',
        'GET|HEAD up',
    ]);
});

it('keeps Fortify installed but closed until ACC-03', function () {
    expect(class_exists(Fortify::class))->toBeTrue();
    expect(config('fortify.features'))->toBe([]);

    $this->post('/login', ['email' => 'a@example.com', 'password' => 'x'])->assertNotFound();
});
