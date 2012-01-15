<?php
# pull standings
$standings = array("agents"=>array(),"NPCCorporations"=>array(),"factions"=>array());
foreach($chars as $char) {
  $url = "http://api.eve-online.com/char/Standings.xml.aspx?apiKey=".$char["apiKey"]."&characterID=".$char["characterID"]."&userID=".$char["userID"];
  $xml = simplexml_load_file($url);
  $types = $xml->result->characterNPCStandings;
  for($i=0;$i<count($types->rowset);$i++){
    $rowset = $types->rowset[$i];
    $typeName = $rowset["name"]."";
    for($j=0;$j<count($rowset->row);$j++){
      $row = $rowset->row[$j];
      $from = $row["fromName"]."";
      $s = $row["standing"]."";
      if (!isset($standings[$typeName][$from])) $standings[$typeName][$from] = array();
      $standings[$typeName][$from][$char["name"]] = $s;
    }
  }
}
# fill in the zeroes...
foreach($standings as $typeName=>$fromNames)
  foreach($standings[$typeName] as $fromName=>$from)
    foreach($chars as $char)
      if (!isset($standings[$typeName][$fromName][$char["name"]]))
        $standings[$typeName][$fromName][$char["name"]] = 0;

# parse
$f = fopen("standings.csv","w");
$charNames = "";
foreach($chars as $char) {
  $charNames .= $char["name"].",";
}
fwrite($f,"From Name,".$charNames."\n");

foreach($standings as $typeName=>$standing){
  fwrite($f,$typeName."\n");
  foreach($standing as $fromName=>$charStandings){
    fwrite($f,$fromName);
    foreach($chars as $char){
      fwrite($f,",".$charStandings[$char["name"]]);
    }
    fwrite($f,"\n");
  }
}

fclose($f);
?>