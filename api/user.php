<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    session_start();
    // $_SESSION['user'] = [
    //     'id' => 1,
    //     'name' => 'Константин',
    // ];

    $data = isset($_SESSION['user']) ? $_SESSION['user'] : false;

    sendJson($data);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}