<?php if (!function_exists("encrypt")) include "functions.php";
# this file is invoked when input is called with new characters
# it may also be called via cronjob or command line

if (!isset($key)) {
  if (!isset($_GET['key'])) {
    echo "missing key\n";
    exit();
  }
  $key = $_GET['key'];
}
require_once "key.php";
if ($key != $correctKey) {
  echo "incorrect key\n";
  exit();
}

# preliminary
echo "loading characters.txt...\n";
$chars = explode("\n",file_get_contents("characters.txt"));
unset($chars[count($chars)-1]);
for($i=0;$i<count($chars);$i++) {
  $char = explode(",",decrypt($chars[$i],$key));
  $chars[$i] = array("name"=>$char[0],"userID"=>$char[1],"apiKey"=>$char[2],"characterID"=>$char[3]);
  echo "  ".$chars[$i]["name"]."\n";
}
echo "done\n";

# each of these will generate a css
require_once "skills.php";
require_once "standings.php";


?>