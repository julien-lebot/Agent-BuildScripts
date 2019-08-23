#Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen ' - Setting up SSH service'
#if (Get-Service -Include "ssh-agent") {
#    # By default it is disabled on Windows 10
#    Set-Service ssh-agent -StartupType Automatic
#    Start-Service ssh-agent
#}
#cmd /C start-ssh-agent.cmd
#ssh-keyscan github.com >> ~/.ssh/known_hosts

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen ' - Cloning Agent repository'
New-Item -ItemType Directory -Force -Path $env:GOPATH/src/github.com/DataDog/
cmd /C "git clone git@github.com:DataDog/datadog-agent.git $env:GOPATH/src/github.com/DataDog/datadog-agent"
Set-Location $env:GOPATH/src/github.com/DataDog/datadog-agent

Write-Host -ForegroundColor Yellow -BackgroundColor DarkGreen ' - Installing requirements'
pip install -r requirements.txt
