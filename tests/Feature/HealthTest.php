<?php

it('reports the application and its database as up', function () {
    $this->getJson('/up')
        ->assertOk()
        ->assertExactJson(['status' => 'up', 'database' => 'up']);
});

it('never starts a session for a health probe', function () {
    $this->get('/up')->assertOk()->assertCookieMissing(config('session.cookie'));
});

it('reports down with 503 and no error detail when the database is unreachable', function () {
    $default = config('database.default');
    config([
        'database.connections.unreachable' => [...config("database.connections.{$default}"), 'port' => 1],
        'database.default' => 'unreachable',
    ]);

    try {
        $response = $this->getJson('/up');
    } finally {
        config(['database.default' => $default]);
    }

    $response->assertStatus(503)->assertExactJson(['status' => 'down', 'database' => 'down']);
});
