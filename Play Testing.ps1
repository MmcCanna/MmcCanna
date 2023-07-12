Get-Process
$process = Get-Process

#--------------------------------------
# not using variable 
Get-Process | Where-Object {$_.cpu -gt 5000} #find processes keeping the CPU busy 
Get-Process | Where-Object WorkingSet64 # sorts processes by memory uasge 
#--------------------------------------
#using variable 
$process = Get-Process 
$process | Where-Object {$_.CPU -gt 5000} #find processes keeping the CPU busy 
$process | Where-Object WorkingSet64  # sorts processes by memory uasge 
#--------------------------------------
$myNewVariable = $true

#--------------------------------------
$total ='2 + 2'
$total 
$total | Get-Member
#--------------------------------------

#--------------------------------------
$num1 = 2
$num2 = 2 
$total = $num1 + $num2
$total
#--------------------------------------
$num1 = '2'
$num2 = '2'
$total = $num1 + $num2
$total
#--------------------------------------
[int]$num1 = '2'
[int]$num2 = '2'
$total = $num1 + $num2 

$stringReturn = $total.ToString()

#--------------------------------------

#--------------------------------------
$literal = 'Two plus one eaquals: $(1+2)'
$literal
$escaped = "Two plus ome equals $(1 + 2)"
$escaped

write-host '$escaped'
write-host "$escaped"

Get-ChildItem env:
#--------------------------------------

#--------------------------------------
#putting it all together 
$path = Read-Host -Prompt 'Please enter the file path you with to scan for large files...'
$rawFileData = Get-ChildItem -Path $path -Recurse
$largeFiles = $rawFileData | Where-Object {$_.Length -gt 1000MB}
$largeFileCount = $largeFiles | Measure-Object | Select-Object -ExpandProperty Count
Write-Host "You have $largeFileCount large file(s) in $path"