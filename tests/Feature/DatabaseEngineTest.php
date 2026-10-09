<?php

use Illuminate\Support\Facades\DB;

// D-041: a run against SQLite or any other engine fails here instead of passing.
it('runs against PostgreSQL 16, never a lighter substitute', function () {
    $connection = DB::connection();

    expect($connection->getDriverName())->toBe('pgsql');

    $versionNum = (int) DB::scalar('show server_version_num');
    expect(intdiv($versionNum, 10000))->toBe(16);

    expect(DB::scalar('select current_database()'))->toBe('str_host_test');
});
