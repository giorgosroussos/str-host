<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Inertia\Response;

/**
 * The scaffold's only page: proves the Inertia, Vue, Tailwind and PrimeVue stack
 * renders end to end. It carries no product data.
 */
class HomeController extends Controller
{
    public function __invoke(): Response
    {
        return Inertia::render('Home', [
            'appName' => __('common.app_name'),
            'tagline' => __('common.tagline'),
        ]);
    }
}
