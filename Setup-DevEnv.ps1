Write-Host
'=======================================================
         ____        __        ____
        / __ \____ _/ /_____ _/ __ \____  ____ _
       / / / / __ `/ __/ __ `/ / / / __ \/ __ `/
      / /_/ / /_/ / /_/ /_/ / /_/ / /_/ / /_/ /
     /_____/\__,_/\__/\__,_/_____/\____/\__, /
                                       /____/
=======================================================
                    * WinDog Setup *'

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Getting Chocolatey'
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Imports 'Update-SessionEnvironment' so we can reload env variables without restarting the process
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force;

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Getting git'
cinst -y git

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Getting 7zip'
cinst -y 7zip

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Visual Studio build tools'
cinst -y visualstudio2017buildtools --params "--add Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Win81"

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Visual C++ Workload'
cinst -y visualstudio2017-workload-vctools

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installinc VC Tools for Python 2.7'l
cinst -y vcpython27

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Wix'
cinst -y wixtoolset

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing CMake'
cinst -y cmake
[Environment]::SetEnvironmentVariable(
    "Path",
    [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine) + ";${env:ProgramFiles}\CMake\bin",
    [System.EnvironmentVariableTarget]::Machine)

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Golang'
cinst -y golang

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Python'
cinst -y python2

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Ruby'
cinst -y ruby --version 2.4.3.1 

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing MSYS'
cinst -y msys2

# Reload environment to get ruby in path
Update-SessionEnvironment

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Bundler'
gem install bundler

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen '- Installing Mingw'
ridk install 3

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen ' * DONE *'

#Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen 'Setup Agent ? [yes/no]'
#$setupAgent = Read-Host
#if ($setupAgent -eq "yes") {
#    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('http://COMP11529:8888/Setup-Agent.ps1'))
#}

#Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen 'Build Agent ? [yes/no]'
#$buildAgent = Read-Host
#if ($buildAgent -eq "yes") {
#    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('http://COMP11529:8888/Build-Agent.ps1'))
#}