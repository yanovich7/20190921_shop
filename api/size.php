<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    $categoryId = empty($_GET['category']) ? 1 : (int) $_GET['category'];

    $query = 'SELECT * FROM `sizes` WHERE category_id = '.$categoryId.' ORDER BY pos';
    $data = dbGetAssocData($query);
    $data = array_merge([0 => ['id' => 0, 'name' => 'Все размеры']], $data);

    sendJson($data);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}