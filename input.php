<?php include "functions.php";
# take parameters, match with characters.txt
# any characters in parameters not in file get added to file

if (!isset($_GET['key'])) exit();
$key = $_GET['key'];
$encrypted = file_get_contents("correct.txt",'r');
$decrypted = decrypt($encrypted,$key);
if ($decrypted != "correct") exit();

# load charsIn
$charsIn = explode("\n",file_get_contents("characters.php"));
for($i=1;$i<count($charsIn)-1;$i++){
  $charsIn[$i]=explode(",",decrypt($charsIn[$i],$key));
}

# load charsOut
$userIDs = explode(",",$_GET['userIDs']);
$apiKeys = explode(",",$_GET['apiKeys']);
$charNames = explode(",",$_GET['charNames']);
$url = "http://api.eve-online.com/eve/CharacterID.xml.aspx?names=".implode(",",$charNames).",\n";
$xml = simplexml_load_file($url);
$charsOut = array();
$rows = $xml->result->rowset;
# compare charsOut with charsIn
$changed = false;
for($i=0;$i<count($rows->row)-1;$i++) {
  $row = $rows->row[$i];
  $name=$row["name"]."";
  $characterID=$row["characterID"]."";
  $apiKey=$apiKeys[$i];
  $userID=$userIDs[$i];
  $found = false;
  for($j=0;$j<count($charsIn);$j++) {
    if ($name == $charsIn[$j][0]) {
      $found = true;
    }
  }
  if (!$found) {
    fwrite(fopen("characters.txt",'a'),encrypt($name.",".$userID.",".$apiKey.",".$characterID,$key)."\n");
    echo "added ".$name."\n";
    $changed = true;
  }
}

# rerun scripts
if ($changed) include "scripts.php";
else echo "nothing added";


?>