<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');
include('../api/price_data.php');

try {
    $categoryId = empty($_GET['category']) ? 0 : $_GET['category'];
    $sizeId = empty($_GET['size']) ? 0 : $_GET['size'];
    $costId = empty($_GET['cost']) ? 0 : $_GET['cost'];

    $conditions = [];
    $join = '';
    if ( !empty($categoryId) ) {
        $conditions[] = 'items.category_id = '.(int)$categoryId;
    }
    if ( !empty($sizeId) ) {
        $join = 'JOIN items_sizes its ON items.id = its.item_id ';
        $conditions[] = 'its.size_id = '.(int)$sizeId;
    }
    $cost = (int)$costId;
    if ( !empty($costId) && array_key_exists($costId, $priceData) ) { // isset($priceData[$costId])
        $priceParams = $priceData[$costId];
        $conditions[] = 'items.price BETWEEN '.$priceParams['from'].' AND '.$priceParams['till'];
    }
    $where = (count($conditions) > 0) ? 'WHERE '.implode(' AND ', $conditions) : '';

    $query = 'SELECT items.* FROM `items` '.$join.$where.';';

    $data = dbGetAssocData($query);

    sendJson($data);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}