<?php

// specs/12-testing-acceptance.md §1, D-036: browser tests check every page they visit
// with axe. The critical journeys of §6 join this suite as their packages land; this
// test proves the layer runs on the scaffold page.
it('renders the scaffold page in a browser with no accessibility issue', function () {
    visit('/')
        ->assertSee(__('common.app_name'))
        ->assertSee(__('common.tagline'))
        ->assertNoJavaScriptErrors()
        ->assertNoAccessibilityIssues(3);
});

// specs/02-architecture.md §5, D-018: every font, script, style and image the page
// loads comes from the application's own host.
it('loads every resource from the application host', function () {
    $page = visit('/')->assertSee(__('common.app_name'));

    $origin = $page->script('() => window.location.origin');
    $resources = $page->script('() => performance.getEntriesByType("resource").map((e) => e.name)');

    expect($resources)->not->toBeEmpty();
    foreach ($resources as $url) {
        expect(str_starts_with($url, $origin.'/'))->toBeTrue("third-party resource: {$url}");
    }
});
