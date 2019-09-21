<?php

define('DEVELOPER_MODE', true);

set_error_handler(
    function($errorNum, $errorString, $errorFile, $errorLine, array $errorContext) {
        throw new ErrorException($errorString, 0, $errorNum, $errorFile, $errorLine);
    }
);

// Соединение с БД
function dbGetConnection() {
    static $connection = null;

    if ($connection !== null) {
        return $connection;
    }

    $DB_HOST = 'localhost';
    $DB_USER = 'root';
    $DB_PASS = 'root';
    $DB_NAME = '30032019_catalog';

    try {
        $connection = mysqli_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
    } catch (Throwable $exception) {
        if (DEVELOPER_MODE) {
            $message = $exception->getMessage();
        } else {
            $message = 'Не удалось установить соединение с базой данных.';
        }
        throw new Exception($message);
    }

    mysqli_set_charset($connection, "utf8");   

    return $connection;
}

// Сохранение новых данных в таблицу
function dbInsert(string $tableName, array $data) {
    $fields = [];
    $values = [];
    foreach ($data as $field => $value) {
        $fields[] = '`' . $field . '`';
        $values[] = dbPrepareValue($value);
    }

    $fields = implode(', ', $fields);
    $values = implode(', ', $values);

    $query = "INSERT INTO `$tableName` ($fields) VALUES ($values);";
    return mysqli_query(dbGetConnection(), $query);
}

// Обновление данных в таблице
function dbUpdate(string $tableName, array $data, string $condition) {
    $setData = [];
    foreach ($data as $field => $value) {
        $setData[] = "`$field` = " . dbPrepareValue($value);
    }
    $setData = implode(', ', $setData);

    $query = "UPDATE `$tableName` SET $setData WHERE $condition;";
    return mysqli_query(dbGetConnection(), $query);
}

// Подготовка значения для сохранения в базу данных
function dbPrepareValue($value) {
    if (is_string($value)) {
        $value = mysqli_escape_string(dbGetConnection(), $value);
        $value = "'$value'";
    } elseif (is_bool($value)) {
        $value = (int) $value;
    }
    return $value;
}

// Получение сообщения об ошибках
function dbGetError() {
    return mysqli_error( dbGetConnection() );
}

// Получение ID последне записи в БД
function dbGetInsertId() {
    return mysqli_insert_id( dbGetConnection() );
}

// Вывод результата
function dbShowResult(bool $result) {
    if ($result) {
        if (DEVELOPER_MODE) {
            echo 'Отлично! Все сохранилось!';
        }
    } else {
        if (DEVELOPER_MODE) {
            $message = 'Ошибка SQL: ' . dbGetError();
        } else {
            $message = 'Произошла ошибка при сохранении в базу данных.';
        }
        throw new Exception($message);
    }
}

// Выборка ассоциативного массива данных по запросу
function dbGetAssocData(string $query) {
    $result = mysqli_query(dbGetConnection(), $query);
    if ($result === false) {
        dbShowResult($result);
    }
    return mysqli_fetch_all($result, MYSQLI_ASSOC);
}

// Выборка одиночного значения по запросу
function dbGetSingleValue(string $query) {
    $result = mysqli_query(dbGetConnection(), $query);
    if ($result === false) {
        dbShowResult($result);
    }
    $row = mysqli_fetch_row($result);

    return isset($row[0]) ? $row[0] : null;
}