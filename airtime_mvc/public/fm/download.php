<?php


// it must be the same as in indexer.php
$Root = utf8_decode("");

function checkFileIsInsideRootDirectory($path, $root_directory) {
    $realpath = realpath($path);

    if (!file_exists($realpath))
        die("File is not readable: " . $path);

    // detects insecure path with for example /../ in it
    if (strpos($realpath, $root_directory) === false || strpos($realpath, $root_directory) > 0)
        die("Download from outside of the specified root directory is not allowed!");
}

function forceDownload($path) {
    $realpath = realpath($path);

    if (!is_readable($realpath))
        die("File is not readable: " . $path);

    $savename = (basename($path));

    header("Pragmaes: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
    header("Cache-Control: private", false);
    header("Content-type: application/force-download");
    header("Content-Transfer-Encoding: Binary");
    header("Content-length: " . filesize($path));
    header("Content-disposition: attachment; filename=\"$savename\"");

    readfile("$path");
    exit;
}

if (!isset($_GET['path']))
    die("Path not specified!");

$fullPath = $Root . $_GET['path'];

checkFileIsInsideRootDirectory($fullPath, $Root);

forceDownload($fullPath);

?>