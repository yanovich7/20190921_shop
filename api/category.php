<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    $query = 'SELECT * FROM `categories` ORDER BY pos';
    $data = dbGetAssocData($query);
    $data = array_merge(
        [
            0 => [
                'id' => 0,
                'name' => 'Все категории'
            ]
        ],
        $data
    );

    sendJson($data);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}