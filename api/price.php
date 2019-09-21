<?php

include('../functions/response.php');
include('../api/price_data.php');

$priceData = array_merge([0 => ['id' => 0, 'name' => 'Все варианты']], $priceData);

sendJson($priceData);