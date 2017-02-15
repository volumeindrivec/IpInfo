function Get-IpInfo {
  [cmdletbinding()]

  param(
    [AllowNull()][string[]]$IpAddress
  )


  if ($IpAddress){
    foreach ($Ip in $IpAddress){
      try{
        $Content = Invoke-RestMethod -Uri http://ipinfo.io/$Ip
        $Content | Add-Member -MemberType NoteProperty -Name 'dateretrieved' -Value (Get-Date -Format s) 
        Write-Output $Content
      }
      catch{
        $Code = $_.Exception.Response.StatusCode.Value__
        Write-Verbose ('Error returned.  Code:  {0}' -f $Code)
      }
    }
  }
  else{
    $Content = Invoke-RestMethod -Uri http://ipinfo.io/$Ip
    $Content | Add-Member -MemberType NoteProperty -Name 'dateretrieved' -Value (Get-Date -Format s)
    Write-Output $Content
  }
}
