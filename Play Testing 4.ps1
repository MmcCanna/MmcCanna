#Tow pipelines 
Get-Process #goes to the success screen 
1/0; #goes to the error screen 

#non-termaniting error 
1/0; Write-Host 'Hello, will I run after an error?'

#non-termination errors don't stop loops
$collection = @(
    'C:\Test',
    'C:\Test\ReadMe.txt',
    'C:\Errorfiles'
)
foreach ($item in $collection){
    Get-Item $item
}

#throw causes Powershell to terminate
try{
    1/0; Write-Host "Hello, will I rum after am error?"
}
catch{
    throw
}

#this will not run go to the catch and will run the write-host
try{
    Get-Item -Path C:\nope\nope.txt; Write-Host "Hello, will I rum after am error?"
}
catch{
    Write-Host 'You are now in the catch'
}
#this looks for not a process then loops back to check if notepad is open

$processNames =@(
    'NotAProcess',
    'Notepad'
)
foreach ($item in $processNames){
    try{
        Get-Process -Name $item
    }
    catch{
        Write-Host $item 
        throw #aka hault all further action
    }
}

#Fianlly 
try{
    Get-Content -Path C:\nope\nope.txt -ErrorAction Stop
}
catch{
    Write-Error $_
}
finally{
    #log results to a logging file
}

#The website exists, but the page does not
#this code writes the user a readable error 
try{
    $webResults = Invoke-WebRequest -Uri 'https:\\...' -Erroraction Stop
}
catch{
    $theError = $_ 
    if($theError.Exception -like "*404*"){
        Write-Warning 'Web page not found. Check the address and try again.'
    }
    else{
        throw
    }
}

#Common Use
$uri = Read-Host 'Enter the URL'
try{
    $webResults = Invoke-WebRequest -Uri $uri -ErrorAction Stop 
}
catch{
    $statusCodeValue = $_.Exception.Response.StatusCode.value__
    switch ($statusCodeValue) {
        400{
            Write-Warning -Message "HTTP Status Code 400 Bad Request. Check the URL adn try again."
        }
        401{
            Write-Warning -Message "HTTP Status Code 401 Unathorized."
        }
        403{
            Write-Warning -Message "HTTP Status Code 403 Forbidden. Server may be having issues. Check the URL and try again."
        }
        404{
            Write-Warning -Message "HTTP Status Code 404 Not Found. Check the URL and try again."
        }
        500{
            Write-Warning -Message "HTTP Status Code 500 Internal Server Error"
        }
        Default { throw }
    }
}