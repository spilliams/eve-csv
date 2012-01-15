<?php
echo "SKILLS SCRIPT\n";
# load skill tree into lookup table
echo "loading skills tree into lookup table...";
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
echo "done\n";

//print_r($lookup);exit();

# pull characters' skills
echo "pulling characters' skills...";
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
echo "done\nfilling in the zeroes...";
# fill in the zeroes...
foreach($skills as $skillName=>$skillChars)
  foreach($chars as $char)
    if (!isset($skills[$skillName][$char["name"]]))
      $skills[$skillName][$char["name"]]=0;
echo "done\n";
# fill in skills nobody has
echo "filling in empty skills...";
$empty = array();
foreach($chars as $char)
  $empty[$char["name"]] = 0;
foreach($lookup as $typeID=>$typeName)
  if (!isset($skills[$typeName]))
    $skills[$typeName] = $empty;
echo "done\n";

//print_r($skills);exit();

# open up a csv file, write to it
echo "writing to csv...";
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
echo "done\n";
?>