function Get-IpInfo {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory=$True)][string[]]$IpAddress
    )


    
    foreach ($Ip in $IpAddress){
        try{
            $Result = Invoke-WebRequest -Uri http://ipinfo.io/$Ip/json
            $Content = $Result.Content
            $Obj = $Content | ConvertFrom-Json

            Write-Output $Obj
        }
        catch{
            $Code = $_.Exception.Response.StatusCode.Value__
            Write-Verbose "Error returned.  Code:  $Code"
            #Write-Error "$_.Exception"
        }
    }

}
