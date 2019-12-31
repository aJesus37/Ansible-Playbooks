$userlist=$(net user /domain) # Get all the users in the domain
$userlist=$($userlist -split "  " | Where-Object { $_ -imatch "\w+" }).Trim() # Separe in lines and get only the lines with content
$userlist=$userlist[17..($($userlist).length-5)] # Get only the lines with users (remove text from the net user command)

$userdata=$userlist | ForEach-Object { $(net user $_ /domain | Select-String -Pattern "User name|Last Logon|Account active|Account expires"; if (-not $?){ Write-Error "$_"};Write-Output "") } # Get the user name, last logon and if the account is active for each user in the list
$usernames=$($($($userdata | Select-String "User name") -replace "(?:(User name)\w*)","").Trim()).Split("`n") # Get the usernames list
$userstatus=$($($($userdata | Select-String "Account active") -replace "(?:(Account active)\w*)","").Trim()).Split("`n") # Get the account status list
$lastlogon0=$($($($userdata | Select-String "Last logon") -replace "(?:(Last logon)\w*)","").Trim()).Split("`n") # Get the last logon time list
$expires0=$($($($userdata | Select-String "Account expires") -replace "(?:(Account expires)\w*)","").Trim()).Split("`n") # Get if account has expiring date
$lastlogon=@() # Create empty array variable
$lastlogon+=$lastlogon0 | ForEach-Object { if($_ -imatch "Never"){ "$_" } else { "$_".replace("?","")} } # Remove the interrogation characters that came with the net user command
$expires=@()
$expires+=$expires0 | ForEach-Object { if($_ -imatch "Never"){ "$_" } else { "$_".replace("?","")} } # Remove the interrogation characters that came with the net user command

[Int32]$totalValues=$usernames.Count # Get the total amount of values

$csv=@() # Create empty array variable
for([Int32]$i=0; $i -lt [Int32]$totalValues; $i++){ # Add each group ou user, status and last logon to a new line as csv.
    if($userStatus[$i] -eq "No"){
        continue
    }
    $csv+="`"$($usernames[$i])`", `"$($userStatus[$i])`",`"$($lastlogon[$i])`",`"$($expires[$i])`"";
    } 

[System.Array]$csv[0..$($($csv.Length)-1)] #| Out-File lastLogonList2.csv -Append -Encoding utf8 # Output csv to file