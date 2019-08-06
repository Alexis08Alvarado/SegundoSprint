#!/usr/bin/pwsh 
param( 
  [string]$vcenter, 
  [string]$username, 
  [string]$password 
)
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false -Scope User -ParticipateInCEIP:$false | Out-Null 
Connect-VIServer -Server $vcenter -Protocol https -User $username -Password $password | Out-Null
Get-VM | Where-Object {$_.Notes -like "*103107*"} | Select-Object Name, PowerState, @{N="DnsName"; E={$_.ExtensionData.Guest.Hostname}}, NumCpu, MemoryGB | ConvertTo-Csv  

