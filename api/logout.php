<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    session_start();
    unset($_SESSION['user']);
    session_destroy();

    sendJson(true);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}