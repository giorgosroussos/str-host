<?php

namespace App\Http\Controllers;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Throwable;

/**
 * Liveness of the application and its database, for `make smoke` and the
 * production proxy. The body never carries an exception message or any
 * configuration detail.
 */
class HealthController extends Controller
{
    public function __invoke(): JsonResponse
    {
        try {
            DB::select('select 1');
            $database = 'up';
        } catch (Throwable $e) {
            report($e);
            $database = 'down';
        }

        $up = $database === 'up';

        return response()->json(
            ['status' => $up ? 'up' : 'down', 'database' => $database],
            $up ? 200 : 503,
        );
    }
}
