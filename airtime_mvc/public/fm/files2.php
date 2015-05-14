<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />


</head>
<body>

<?php




$theList = ''; // initialize the variables you're using!
$allowed = array("jpg" => true, "jpeg" => true);
$it = new RecursiveDirectoryIterator('/srv/airtime/stor/recorded');
$rit = new RecursiveIteratorIterator($it);
foreach ($rit as $file) {
  $pos = strrpos($file, '.');
  if ($pos === false) {
    // file doesn't contain a . (has no extension)
    continue;
  }
  // file might be named foo.JPG (sadly quite common for windows / certain cameras)
  $extension = strtolower(substr($file, $pos+1));
  if (!isset($allowed[$extension])) { // this is a bit faster than in_array()
    // $extension is not allowed
    continue;
  }

  // what happens with your class, when you encounter a sub-directory like images2/my-images/easter-holidays/foo.jpg
  // that won't be accessible from CSS (without major escaping action)
  // try to keep classNames alphanumeric (like-this-class-name)
  $path = $file->getPath();
  $folder = ltrim($path, "/srv/airtime/stor/recorded/");

  // always, ALWAYS, respect the context! 
  // htmlspecialchars() go around any non-literal output you make!
  $thelist .= '<div class="' . htmlspecialchars($folder) . '"><a href="'
    . htmlspecialchars($file->getPath()) . '/' . htmlspecialchars($file->getFilename()) 
    . '"rel="shadowbox[' . htmlspecialchars($file->getPath()) . ']">' 
    . '<img src="../slir/w180-h180-c1:1/test/isotope/' . htmlspecialchars($file->getPath()) 
    . '/' . htmlspecialchars($file->getFilename()) . '" /></a></div>';
}





	


?>

</body>
</html>

