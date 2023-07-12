$webResults  = Invoke-WebRequest -Uri 'https://reddit.com/r/powershell.json'
$rawjSon = $webResults.Content
$abjData = $rawjSon | ConvertFrom-Json
$posts = $abjData.data.children.data
$posts | Select-Object Title,Score | Sort-Object Score -Descending

[int]$numPosts = Read-Host Prompt "Enter the number of posts to read"

$posts | Select-Object Tital,url | Sort-Object Score -Descending | Select-Object -First $numPosts

#-------------------------------------------------------------

#getContent

$logContent = Get-Content 'C:\Test\Read Me.txt'
$logContent = Select-String -Pattern "ERROR"
$regex = "\b\d{1,3}\.\d{1,3}\.\d{1,3}\b" #This is fo checking logs for IP addy 
$logContent | Select-String -Pattern $regex -AllMatches

$logContent | Where-Object {$_ -like "*.*.*.*"} #Similar to regex but not as efficent

$raw = Get-Content 'C:\Test\Read Me.txt' -Raw # will not return the ERROE line for pattern 

#-------------------------------------------------------------
#-------------------------------------------------------------

$hostInfo = Get-Host
Write-host = $hostInfo
Write-host = $hostInfo.Version

#color change (not used too much)

Write-Host "Warning" -ForegroundColor Yellow
Write-Host "Error" -ForegroundColor Red
Write-Host "Works Great" -ForegroundColor Green
Write-Host "Critical Error" -BackgroundColor Red -ForegroundColor White

#outfile 

$processes = Get-Process
$processes | Out-File -Path 'C:\Test\Info.txt'

$processes | ConvertTo-Csv -NoTypeInformation | Out-File C:\Test\processes.csv
