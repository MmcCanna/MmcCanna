$evalPath = Test-Path $path 
if ($evalPath -eq $true) {
    Write-Host "$path VERIFIED"
}
elseif ($evalPath -eq $false){
    Write-Host "$path NOT VERIFIED"
}
#----------------------------------------------------
#switch
[int]$aValue = Read-Host 'Enter a number'
switch ($aValue){
        1{
            Write-Host 'You entered the number ONE'
        }
        2{
            Write-Host 'You entered the number TWO'
        }
        3{
            Write-Host 'You entered the number THREE'
        }
        4{
            Write-Host 'You entered the number FOUR'
        }
        5{
            Write-Host 'You entered the number FIVE'
        }
    Default{
        "I do not reconize $aValue"
    }
}

#---------------------------------------------------------

#for 
for($i = 5; $i -le 15; $i++) {
    Write-Host $i -ForegroundColor $i
}

$aString = 'Jean-Luc Picard'
$reverseString = ''
for ($i = $aString.Length; $i -ge 0; $i--){
    $reverseString += $aString[$i]
}
$reverseString

#foreach loop

$path = 'C:\Test'
[int]$totalSize = 0 
$fileInfo  = Get-ChildItem $path -Recurse
foreach ($file in $fileInfo){
    $totalSize += $file.Length
}
Write-Host "The total size of the file in $path is $($totalSize /1MB) MB."

#-------------------------------------------------------------
#do while loop
$pathVerified = $false
do {
    $path = Read-Host 'Please enter a file path to evaluate'
    if(Test-Path $path){
        $pathVerified = $true
    }
}while($pathVerified -eq $false)
#-------------------------------------------------------------
#while loop
$pathVerified = $true 
while($pathVerified -eq $false){
    $path = Read-Host 'Please enter a file path to evaluate'
    if (Test-Path $path){
        $pathVerified = $true
    }
}
#-------------------------------------------------------------
#Where-object
$largeProcesses = Get-Process | Where-Object {$_.WorkingSet64 -gt 50MB}

$largeProcesses = @()
$processes = Get-Process
foreach ($process in $processes){
    if($process.WorkingSet64 -gt 50MB){
    $largeProcesses += $process
    }
}

#ForEachObject

$path = 'C:\Test'
$folderCount = 0
Get-ChildItem $path | ForEach-Object -Process {if ($_.PSIscontainer){
    $folderCount++
}}
$folderCount
#-------------------------------------------------------------
#Set your variables
[int]$fileCount = 0 
[int]$folderCount = 0
[int]$totalSize = 0 

#Set the file path to analyze
$path = 'C:\Test'
#get the file information
$rawFileInfo = Get-ChildItem $path -Recurse
#Set the for looping file information
foreach ($item in $rawFileInfo){
    if($item.PSIscontainer){
        #PSI meaning folder or directiory total
        $folderCount++
    }
    else{
        #This file is not a PSI counter
        $fileCount++
        $totalSize += $item.Length
    }
}
#generate an output to check whats going on 
Write-Host "Breakdown of $path"
Write-Host "Total directories: $folderCount"
Write-Host "Total Files: $fileCount"
Write-Host "Total Size of files: $($totalSize /1MB) MB"