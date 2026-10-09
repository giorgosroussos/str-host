<?php

use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Vite;
use Inertia\Testing\AssertableInertia as Assert;

it('renders the scaffold page through Inertia with translated props', function () {
    $this->get('/')
        ->assertOk()
        ->assertInertia(fn (Assert $page) => $page
            ->component('Home')
            ->where('appName', __('common.app_name'))
            ->where('tagline', __('common.tagline')));
});

// specs/02-architecture.md §5, D-018: no font, script, style or tile from another host.
// Two guards at the HTTP and source level; tests/Browser/HomePageTest.php checks every
// resource the browser actually loads.
it('emits asset tags only for the application or its local Vite server', function () {
    // Render with real @vite tags (not the withoutVite() fake), served by a dev server.
    $this->withVite();
    $hot = storage_path('framework/testing/vite.hot');
    File::put($hot, 'http://127.0.0.1:5173');
    Vite::useHotFile($hot);

    try {
        $html = (string) $this->get('/')->assertOk()->getContent();
    } finally {
        File::delete($hot);
    }

    preg_match_all('/<(?:script|link)\b[^>]*\b(?:src|href)\s*=\s*["\']([^"\']+)["\']/i', $html, $matches);
    $urls = $matches[1];

    expect($urls)->toContain('http://127.0.0.1:5173/@vite/client')
        ->and($urls)->toContain('http://127.0.0.1:5173/resources/js/app.ts');

    $appHost = parse_url((string) config('app.url'), PHP_URL_HOST);
    foreach ($urls as $url) {
        $host = parse_url($url, PHP_URL_HOST);
        expect(in_array($host, [null, $appHost, '127.0.0.1', 'localhost'], true))
            ->toBeTrue("third-party asset: {$url}");
    }
});

it('references no third-party host anywhere in the frontend sources', function () {
    $files = collect(File::allFiles(resource_path()))
        ->filter(fn (SplFileInfo $file) => in_array($file->getExtension(), ['php', 'vue', 'ts', 'js', 'css'], true));

    expect($files)->not->toBeEmpty();

    foreach ($files as $file) {
        preg_match_all('#(?:https?:)?//([a-z0-9.-]+\.[a-z]{2,})#i', File::get($file->getPathname()), $matches);
        expect($matches[1])->toBeEmpty("{$file->getRelativePathname()} references ".implode(', ', $matches[1]));
    }
});
