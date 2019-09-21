<?php

include('../functions/arrays.php');
include('../functions/db.php');
include('../functions/response.php');

try {
    // $salt = '#ghdfjgk$H&(jfslkdjsdf#klf;lk;sfgnm,mn,@';
    // $passwordHash = sha1($salt . $password);

    session_start();

    $login = empty($_GET['login']) ? false : trim($_GET['login']);
    $password = empty($_GET['password']) ? false : trim($_GET['password']);

    $query = 'SELECT id, name, surname FROM users 
        WHERE login="'.$login.'" AND password="'.sha1($password).'"
        LIMIT 1;';
    $data = dbGetAssocData($query);

    if (empty($data)) {
        $result = false;
    } else {
        $data = $data[0];
        $_SESSION['user'] = $data;
        session_commit(); // alias session_write_close()
        $result = $data;
    }

    sendJson($result);
} catch (Throwable $exception) {
    sendResponse( $exception->getMessage(), 500 );
}