<?php

use Inertia\Testing\AssertableInertia as Assert;

it('renders the scaffold page through Inertia with translated props', function () {
    $this->get('/')
        ->assertOk()
        ->assertInertia(fn (Assert $page) => $page
            ->component('Home')
            ->where('appName', __('common.app_name'))
            ->where('tagline', __('common.tagline')));
});

it('loads nothing from a third-party host', function () {
    // specs/02-architecture.md §5, D-018: no font, script, style or tile from another host.
    $html = $this->get('/')->assertOk()->getContent();

    preg_match_all('/\b(?:src|href)\s*=\s*["\']([^"\']+)["\']/i', (string) $html, $matches);
    $appHost = parse_url((string) config('app.url'), PHP_URL_HOST);

    foreach ($matches[1] as $url) {
        $host = parse_url($url, PHP_URL_HOST);
        expect($host === null || $host === $appHost || $host === 'localhost' || $host === '127.0.0.1')
            ->toBeTrue("third-party asset: {$url}");
    }
});
