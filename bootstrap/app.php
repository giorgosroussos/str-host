<?php

use App\Http\Controllers\HealthController;
use App\Http\Middleware\HandleInertiaRequests;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        then: function (): void {
            // Health probe for `make smoke` and the production proxy. It sits outside
            // the `web` group so a probe never starts a session, and it replaces the
            // framework's `health:` page, which loads fonts and scripts from third-party
            // hosts (specs/02-architecture.md §5, D-018).
            Route::get('/up', HealthController::class)->name('health');

            // Per-surface route folders (specs/02-architecture.md §4). Every file in the
            // folder is loaded, so a package adds a route file instead of editing a
            // shared one. Authentication and role middleware arrive with ACC-01/ACC-03.
            $surfaces = [
                'staff' => ['prefix' => 'app', 'name' => 'staff.'],
                'owner' => ['prefix' => 'owner', 'name' => 'owner.'],
            ];

            foreach ($surfaces as $folder => $options) {
                Route::middleware('web')
                    ->prefix($options['prefix'])
                    ->name($options['name'])
                    ->group(function () use ($folder): void {
                        foreach (glob(base_path("routes/{$folder}/*.php")) ?: [] as $file) {
                            require $file;
                        }
                    });
            }
        },
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->web(append: [
            HandleInertiaRequests::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->is('api/*') || $request->expectsJson(),
        );
    })->create();
