<?php

function view(string $__path, array $__data = []): string
{
    $__path = $_SERVER['DOCUMENT_ROOT'] . '/view/' . $__path . '.php';
    extract($__data); // ['a' => 'Эл.1', 'b' => 'Эл.2'] --> $a = 'Эл.1'; $b = 'Эл.2'; 
    ob_start();
    include($__path);
    return ob_get_clean();
}

function batchView(array $data): array
{
    $blocks = [];
    foreach ($data as $key => $datum) {
        if (is_int($key)) {
            $blocks[] = view($datum);
        } else {
            $blocks[] = view($key, $datum);
        }
    }
    return $blocks;
}

function sendResponse(string $message, int $code = 200) {
    http_response_code($code);
    header("Content-Type: text/html");
    die($message);
}

function sendJson($data, int $code = 200) {
    sendResponse(json_encode($data), $code);
}