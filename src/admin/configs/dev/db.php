<?php
$db['master'] = array(
    'type' => Swoole\Database::TYPE_MYSQLi,
    'host' => "127.0.0.1",
    'port' => 3306,
    'dbms' => 'mysql',
    'user' => "root",
    'passwd' => "123456",
    'name' => "crontask",
    'charset' => "utf8",
    'setname' => true,
    'persistent' => false, //MySQL长连接
);
return $db;