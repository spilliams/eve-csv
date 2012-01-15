<?php if (!function_exists("encrypt")) include "functions.php";
# this file is invoked when input is called with new characters
# it may also be called via cronjob or command line

if (!isset($key)) {
  if (!isset($_GET['key'])) exit();
  $key = $_GET['key'];
}
require_once "key.php";
if ($key != $correctKey) exit();

# preliminary
$chars = explode("\n",file_get_contents("characters.txt"));
for($i=0;$i<count($chars);$i++) {
  $char = explode(",",decrypt($chars[$i],$key));
  $chars[$i] = array("name"=>$char[0],"userID"=>$char[1],"apiKey"=>$char[2],"characterID"=>$char[3]);
}

# each of these will generate a css
require_once "skills.php";
require_once "standings.php";


?>