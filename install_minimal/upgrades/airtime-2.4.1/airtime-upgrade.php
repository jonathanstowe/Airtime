<?php

require_once 'DbUpgrade.php';

$filename = "/usr/local/etc/airtime/airtime.conf";
$values = parse_ini_file($filename, true);

AirtimeDatabaseUpgrade::start($values);
