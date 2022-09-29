# PowerShell script that creates a Scheduled Task that triggers on Event ID 102 from the SmartCard-DeviceEnum/Operational log, the removal/unplugging of a FIDO2 security device.
# Two options: Either Log off or Lock the computer when the FIDO2 security is removed.
# Questions? Ping andreas.stenhall@coligo.se via Teams or on Twitter https://twitter.com/AndreasStenhall
# ===================================

# Use the action below if you want to lock the machine when unplugging the FIDO2 security key. 
$Action = New-ScheduledTaskAction -Execute "Rundll32.exe" -Argument "user32.dll,LockWorkStation"

# Use the action below if you want to log off the machine when unplugging the FIDO2 security key
#$Action = New-ScheduledTaskAction -Execute "logoff.exe"

$CIMTriggerClass = Get-CimClass -ClassName MSFT_TaskEventTrigger -Namespace Root/Microsoft/Windows/TaskScheduler:MSFT_TaskEventTrigger
$Trigger = New-CimInstance -CimClass $CIMTriggerClass -ClientOnly
$Trigger.Subscription = 
@"
<QueryList><Query Id="0" Path="Microsoft-Windows-SmartCard-DeviceEnum/Operational"><Select Path="Microsoft-Windows-SmartCard-DeviceEnum/Operational">*[System[Provider[@Name='Microsoft-Windows-SmartCard-DeviceEnum'] and EventID=102]]</Select></Query></QueryList>
"@
$Trigger.Enabled = $True 
Register-ScheduledTask -Action $Action -Trigger $Trigger -TaskName "[CUSTOM] FIDO2 security key removal task"  -Description "FIDO2 security key removal task actions" -User $env:UserName -Force 
