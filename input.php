<?php
# take parameters, match with characters.txt
# any characters in parameters not in file get added to file

# load charsIn
$charsIn = explode("\n",file_get_contents("characters.txt"));
for($i=0;$i<count($charsIn);$i++){
  $charsIn[$i]=explode(",",$charsIn[$i]);
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
    fwrite(fopen("characters.txt",'a'),$name.",".$userID.",".$apiKey.",".$characterID."\n");
    echo "added ".$name."\n";
    $changed = true;
  }
}

# rerun scripts
if ($changed) include "scripts.php";
else echo "nothing added";
?>