param([String]$IP="")

$temp=$(net localgroup administrators); 
$hostname=$(hostname); 
$temp2=$temp[6..$($($temp).length-3)]; 
$inGroup=$temp2 -replace ".*\\",""; 
$ad=$temp2 | Select-String ".*\\.*"; 
$domains=$ad -replace "\\.*",""; 
$domains=$domains -split"`n"; 
$inGroup=$inGroup -split"`n";
$type=@() # Try to figure out how to define if is user or group
[Int32]$totalValues=$($temp2).Count; 
$csv=@()

for([Int32]$i=0; $i -lt [Int32]$totalValues; $i++){
    if($domains[$i] -eq ""){
        $domains[$i]="local"
    }
    $csv+="`"$($inGroup[$i])`",`"$($type[$i])`",`"$($domains[$i])`",`"$hostname`", `"$IP`"";
    } 
[System.Array]$csv[0..$($($csv.Length)-1)]