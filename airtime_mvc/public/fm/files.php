<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />


</head>
<body>

<?php

$di = new RecursiveDirectoryIterator('/srv/airtime/stor/recorded');


$Root = utf8_decode(""); 

$AllowDownload = TRUE; 
$WebServerPath = dirname($_SERVER['SCRIPT_NAME']) . "/download.php?path=";



foreach (new RecursiveIteratorIterator($di) as $filename => $file) {

$fileonly = basename($file);

echo '<a rel="nofollow" href="download.php?path='. $file .'">' . $fileonly . '</a><br/>';
	
}

?>

</body>
</html>

