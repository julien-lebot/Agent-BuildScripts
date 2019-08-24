# escape=`
ARG WINDOWS_SERVER_VERSION=1903

### STABLE PART OF THE BUILD ###
FROM mcr.microsoft.com/dotnet/framework/runtime:3.5-windowsservercore-${WINDOWS_SERVER_VERSION}

ADD https://aka.ms/vs/15/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.Visualstudio.Component.Windows81sdk `
 || IF "%ERRORLEVEL%"=="3010" EXIT 0
RUN powershell -Command Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN powershell -Command `
	cinst -y 7zip;`
	cinst -y msys2 --params "/NoUpdate"
###

# Things that change often go there...

ENV WIX_VERSION 3.11.1
ENV WIX_PATH 'C:\Program Files (x86)\WiX Toolset v3.11'
RUN powershell -Command `
	$wixVersion = $Env:WIX_VERSION;`
	cinst -y wixtoolset --version $wixVersion;`
	$newPath = ('{0}\bin;{1}' -f $env:WIX_PATH, $env:PATH);`
	Write-Host ('Updating PATH: {0}' -f $newPath);`
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine);

ENV CMAKE_VERSION 3.15.2
RUN powershell -Command `
	$cmakeVersion = $Env:CMAKE_VERSION;`
	cinst -y cmake --version $cmakeVersion --installargs '"ADD_CMAKE_TO_PATH=System"'

ENV RUBY_VERSION 2.4.3.1
RUN powershell -Command `
	Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force;`
	$rubyVersion = $Env:RUBY_VERSION;`
	cinst -y ruby --version $rubyVersion;`
	Update-SessionEnvironment;`
	ridk install 3;`
	gem install bundler

RUN cinst -y python2 vcpython27

# Blatantly stolen from docker-library/golang
ENV GOPATH C:\\gopath
ENV GOLANG_VERSION 1.12.9
ENV GOLANG_SHA256 'ec7550b32ff080b17060b9d4fde7bee94d9cf3c42e846e3a62fe4a3047ec79e3'
RUN powershell -Command `
$newPath = ('{0}\bin;C:\go\bin;{1}' -f $env:GOPATH, $env:PATH);`
	Write-Host ('Updating PATH: {0}' -f $newPath);`
	[Environment]::SetEnvironmentVariable('PATH', $newPath, [EnvironmentVariableTarget]::Machine);
RUN powershell -Command `
	$url = ('https://golang.org/dl/go{0}.windows-amd64.zip' -f $env:GOLANG_VERSION);`
	Write-Host ('Downloading {0} ...' -f $url);`
	$ProgressPreference = 'SilentlyContinue';`
	Invoke-WebRequest -Uri $url -OutFile 'go.zip' -UseBasicParsing ;`
	$sha256 = $env:GOLANG_SHA256;`
	Write-Host ('Verifying sha256 ({0}) ...' -f $sha256);`
	if ((Get-FileHash go.zip -Algorithm sha256).Hash -ne $sha256) {`
		Write-Host 'FAILED!';`
		exit 1;`
	};`
	Write-Host 'Expanding ...';`
	Expand-Archive go.zip -DestinationPath C:\;`
	Write-Host 'Verifying install ("go version") ...';`
	go version;`
	Write-Host 'Removing ...';`
	Remove-Item go.zip -Force;`
	Write-Host 'Complete.'

ENTRYPOINT C:\BuildTools\Common7\Tools\VsDevCmd.bat && ridk enable &&