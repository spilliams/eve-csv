<?php
# load skill tree into lookup table
$url = "http://api.eve-online.com/eve/SkillTree.xml.aspx";
$xml = simplexml_load_file($url);
$lookup = array();
$categories = $xml->result->rowset;
//echo "categories count: ".count($categories->row)."\n";
for($i=0;$i<count($categories->row);$i++) {
  $category = $categories->row[$i]->rowset;
  for ($j=0;$j<count($category->row);$j++) {
    $skill = $category->row[$j];
    //echo "name: ".$skill["typeName"].", ID: ".$skill["typeID"]."\n";
    $lookup[$skill["typeID"].""] = $skill["typeName"]."";
  }
}

//print_r($lookup);exit();

# pull characters' skills
$skills = array();
foreach ($chars as $char) {
  $url = "http://api.eve-online.com/char/CharacterSheet.xml.aspx?apiKey=".$char["apiKey"]."&characterID=".$char["characterID"]."&userID=".$char["userID"];
  //echo "fetching character info for ".$char["name"]." from url ".$url."\n";
  $xml = simplexml_load_file($url);
  $charSkills = $xml->result->rowset;
  for ($i=0;$i<count($charSkills->row);$i++) {
    $row = $charSkills->row[$i];
    $skillName = $lookup[$row["typeID"].""];
    if (!isset($skills[$skillName])) $skills[$skillName] = array();
    $skills[$skillName][$char["name"]] = $row["level"]."";
  }
}

//print_r($skills);exit();

# open up a csv file, write to it
$file = fopen("skills.csv",'w');
$charNames = "";
foreach($chars as $char) {
  $charNames .= $char["name"].",";
}
fwrite($file,"Skill Name,".$charNames."\n");
foreach ($skills as $k=>$v) {
  fwrite($file,$k.",");
  foreach($chars as $char) {
    fwrite($file,$v[$char["name"]].",");
  }
  fwrite($file,"\n");
}

fclose($file);
?>