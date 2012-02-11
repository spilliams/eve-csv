<?php
# this file is invoked when input is called with new characters
# it may also be called via cronjob or command line

# preliminary
echo "loading characters.txt...\n";
$chars = explode("\n",file_get_contents("characters.txt"));

for($i=0;$i<count($chars)-1;$i++) {
  $char = explode(",",$chars[$i]);
  $chars[$i] = array("name"=>$char[0],"userID"=>$char[1],"apiKey"=>$char[2],"characterID"=>$char[3]);
  echo "  ".$chars[$i]["name"]."\n";
}
echo "done\n";

# each of these will generate a css
require_once "skills.php";
require_once "standings.php";


?>