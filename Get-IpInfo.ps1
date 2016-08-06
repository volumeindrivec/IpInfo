function Get-IpInfo {
  [cmdletbinding()]

  param(
    [string[]]$IpAddress
  )


  if ($IpAddress){
    foreach ($Ip in $IpAddress){
      try{
        $Content = (Invoke-WebRequest -Uri http://ipinfo.io/$Ip/json).Content | ConvertFrom-Json
        $Content | Add-Member -MemberType NoteProperty -Name 'dateretrieved' -Value (Get-Date -Format s) 
        Write-Output $Content
      }
      catch{
        $Code = $_.Exception.Response.StatusCode.Value__
        Write-Verbose "Error returned.  Code:  $Code"
        #Write-Error "$_.Exception"
      }
    }
  }
  else{
    $Content = (Invoke-WebRequest -Uri http://ipinfo.io).Content | ConvertFrom-Json
    $Content | Add-Member -MemberType NoteProperty -Name 'dateretrieved' -Value (Get-Date -Format s)
    Write-Output $Content
  }
}
