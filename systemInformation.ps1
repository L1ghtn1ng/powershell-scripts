#Requires –Version 3
 
# variables
$Property = "Name","maxclockspeed","numberOfCores","NumberOfLogicalProcessors","SocketDesignation"
$score = "CPUScore","D3DScore","DiskScore","GraphicsScore","MemoryScore"
$hdd = "Label", "DriveLetter", "Capacity", "FreeSpace", "FileSystem"


# Telling the user what this script is doing
Write-Progress "Gathering System Infomation"
sleep 3

Write-Host ""
Write-Host "Ram Info" -ForegroundColor Green
Get-WMIObject -class "Win32_PhysicalMemory" | Select-Object "Speed", "Capacity" | Format-List

Write-Host ""
Write-Host "Cpu Info" -ForegroundColor Green
Get-WmiObject win32_processor -Property  $Property | Select-Object -Property $Property | Format-List

Write-Host ""
Write-Host "System is running in" -ForegroundColor Green 
IF ($env:PROCESSOR_ARCHITECTURE = "AMD64")
{
    Write-Output "64 Bit" 

}
ELSE
{
    Write-Output "32 Bit" 

}

Write-Host ""
Write-Host "Pc Brand is" -ForegroundColor Green
Get-WmiObject Win32_ComputerSystem | Select-Object "Model" 

Write-Host ""
Write-Host "Computer Name" -foregroundcolor Green
$env:COMPUTERNAME

Write-Host ""
Write-Host "Graphics Card Info" -foregroundcolor Green
Get-WmiObject win32_VideoController | Select-Object "Name" | ft -a 

Write-Host ""
Write-Host "User Profile" -ForegroundColor Green
$env:USERPROFILE 

Write-Host ""
Write-Host "Network Info" -ForegroundColor Green
Get-WmiObject Win32_NetworkAdapter | Select-Object "Name", "MACAddress" | Ft -AutoSize
Get-WmiObject Win32_NetworkAdapterConfiguration | Select-Object "Description", "IPAddress" | Ft -AutoSize

Write-Host ""
Write-Host "Computer Scores" -ForegroundColor Green
Get-WmiObject win32_winSat | Select-Object $score | Format-List

Write-Host ""
Write-Host "Screen Info" -ForegroundColor Green
Get-WmiObject Win32_DeskTopMonitor | Select-Object "ScreenWidth", "ScreenHeight" | Format-List

Write-Host ""
Write-Host "HDD Info" -ForegroundColor Green
Get-WMIObject -class "Win32_Volume" | Select-Object $hdd | Format-List

Write-Host ""
Write-Host "Created By Jay Townsend" -ForegroundColor Yellow

Start-Sleep 1
$psISE.CurrentPowerShellTab.ConsolePane.Text | Set-Content -Path $env:USERPROFILE\Desktop\system.txt
