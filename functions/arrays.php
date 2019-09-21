<?php

// debug - вывод массива на экран
function d(array $array, bool $dieAfter = false) {
    echo '<pre>';
    print_r($array);
    echo '</pre>';

    if ($dieAfter) {
        die;
    }
}

// var dump - вывод подробной информации о значении переменной
function vd($value, bool $dieAfter = false) {
    echo '<pre>';
    var_dump($value);
    echo '</pre>';

    if ($dieAfter) {
        die;
    }
}