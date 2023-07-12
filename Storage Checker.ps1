<#
McCanna Matthew
7/10/2023
Script that tells us when our drive space is low on PC
Script will check for free space
Telegram notification when below 15%
All actions logged 
Script should support scanning a drive when the user specifies
The script will support both Linux and Windows
#>

<#
Supports logging 
Checks desired drive for free space 
Sends Notifications
#>

#Declaring what drive is being used

param (
    [Parameter(Mandatory = $true)]
    [string]
    $drive
)

#log directory
if ($PSVersionTable.Platform -eq 'Unix') {
    $logPath = '/tmp'
}
else {
    $logPath = 'C:\Test\Logs'
}

$logFile = "$logPath\driveCheck.log" #log file

#verify if log directory exsists
try {
    if (-not (Test-Path -Path $logPath -ErrorAction Stop)) {
        #if output is not found this will create one 
        New-Item -ItemType Directory -Path $logPath -ErrorAction Stop | Out-Null
        New-Item -ItemType File -Path $logPath -ErrorAction Stop | Out-Null
    }
}
catch { throw }

Add-Content $logPath -Value "[INFO] Running $PSCommandPath"

#verify that poshGram is installed
if (-not(Get-Module -Name poshGram -ListAvailable)) {
    Add-Content $logPath -Value "[ERROR] PoshGram is not installed."
    throw
}
else {
    Add-Content $logPath -Value "[INFO] PoshGram is Installed."
}
#get the hard drive information

try {
    if ($PSVersionTable.Platform -eq 'Unix') {
        $volume = Get-PSDrive -Name $drive
        #verify volume actually exists
        if ($volume) {
            $total = $volume.Used + $volume.Free
            $percentFree = [int](($volume.Free / $total) * 100)
            Add-Content $logPath -Value "[INFO] Percent Free: $percentFree%"
        }
        else {
            Add-Content -Path $logFile -Value "[ERROR] $drive was not found."
            throw
        }
        else {
            $volume = Get-Volume -ErrorAction Stop | Where-Object ($_.DriveLetter -eq $drive)
            if ($volume) {
                $total = $volume.Size
                $total = $volume.Used + $volume.Free
                $percentFree = [int](($volume.SizeRemaining / $total) * 100)
                Add-Content $logPath -Value "[INFO] Percent Free: $percentFree%"
            }
            else {
                Add-Content -Path $logFile -Value "[ERROR] $drive was not found."
                throw
            }
        }
    }
}
catch {
    Add-Content -Path $logPath -Value "[ERROR] Unable to retrive volume information."
    Add-Content -Path $logPath -Value $_
    throw
}


#send the Telegram message if drive is low
if ($percentFree -le 15) {
    try {
        Import-Module -Name PoshGram -ErrorAction Stop
        Add-Content -Path $logFile -Value "[INFO] Imported PoshGram successfully"
    }
    catch {
        Add-Content -Path $logPath -Value "[ERROR] PoshGram could not be imported:"
        Add-Content -Path $logPath -Value $_
    }
    Add-Content -Path $logFile -Value "[INFO] Sending Telegram notificaion"

    $botToken = "n:x-xxxx"
    $chat = "-n"
    Send-TelegramTextMessage -BotToken $botToken -ChatIT $chat -Message "Drive Storage Low."
}
