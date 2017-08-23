<?php
/**
 * Created by PhpStorm.
 * User: liuzhiming
 * Date: 16-6-12
 * Time: 下午4:41
 */
define('APPSPATH', dirname(__DIR__) . '/admin');
define('WEBPATH', dirname(__DIR__));
date_default_timezone_set("Asia/Shanghai");

$env = get_cfg_var('env.name');
if ($env == "product")
{
    define('DEBUG', 'off');
    define('WEBROOT', 'http://atask.9xkd.com');
}elseif ($env == "test"){
    define('DEBUG', 'on');
    define('WEBROOT', 'http://atask.9xkd.com');
} else {
    $env = 'dev';
    define('DEBUG', 'on');
    define('WEBROOT', 'http://atask.9xkd.com');
}
define('ENV_NAME', $env);

define('PUBLIC_PATH', '/mnt/task/src/framework/swoole/');
require_once PUBLIC_PATH.'libs/lib_config.php';

Swoole::$php->config->setPath(APPSPATH . '/configs');
Swoole::$php->config->setPath(APPSPATH . '/configs/' . ENV_NAME);
Swoole::$php->runMVC();