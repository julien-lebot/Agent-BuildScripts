call C:\BuildTools\Common7\Tools\VsDevCmd.bat
call ridk enable

cd C:\gopath\src\github.com\datadog\datadog-agent
set PYTHONIOENCODING=UTF-8
pip install -r requirements.txt
inv agent.omnibus-build --base-dir=C:\.omnibus-ruby