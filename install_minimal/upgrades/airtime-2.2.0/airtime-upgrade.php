<?php

require_once 'DbUpgrade.php';
require_once 'ConfFileUpgrade.php';
require_once 'common/UpgradeCommon.php';

$filename = "/usr/local/etc/airtime/airtime.conf";
$values = parse_ini_file($filename, true);

AirtimeConfigFileUpgrade::start();
AirtimeDatabaseUpgrade::start($values);
