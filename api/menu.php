<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    // $query = 'SELECT * FROM `menu` WHERE type=0 ORDER BY pos';
    $query = 'SELECT * FROM `menu` ORDER BY type, pos';
    $data = dbGetAssocData($query);

    $result = [
        'header' => [],
        'footer' => [],
    ];
    foreach ($data as $d) {
        $key = ($d['type'] == 0) ? 'header' : 'footer';

        $result[$key][] = [
            'id' => $d['id'],
            'name' => $d['name'],
            'collection' => $d['collection_id'],
        ];
    }

    sendJson($result);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}