<?php

require_once 'DbUpgrade.php';
require_once 'common/UpgradeCommon.php';

$filename = "/usr/local/etc/airtime/airtime.conf";
$values = parse_ini_file($filename, true);

//CC-5001: remove /etc/monit/conf.d/monit-airtime-rabbitmq-server.cfg on 2.3.1 upgrade
$file = "/usr/local/etc/monit.d/monit-airtime-rabbitmq-server.cfg";
if (file_exists($file)) {
    unlink($file);
}

AirtimeDatabaseUpgrade::start($values);
