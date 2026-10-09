<?php

use App\Http\Controllers\HomeController;
use Illuminate\Support\Facades\Route;

// Surface routes live in routes/staff and routes/owner (loaded in bootstrap/app.php);
// the guest (/g/{token}) and cleaner (/c/{token}) surfaces arrive with OUT-02 and OUT-03.
Route::get('/', HomeController::class)->name('home');
