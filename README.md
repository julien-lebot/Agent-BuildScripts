# Build SDK
## Build SDK for Windows 2019 1903
`docker build -t squeakysquak/datadog-agent-sdk:latest -t squeakysquak/datadog-agent-sdk:go1.12.9-windows-1903 -m 2GB .`

## Build SDK for Windows 2019 LTSC 2019
`docker build -t squeakysquak/datadog-agent-sdk:go1.12.9-windows-ltsc2019 -m 2GB --build-arg WINDOWS_SERVER_VERSION=ltsc2019 .`

# Build Agent

Use the following command to build the agent from sources in `C:\dev\datadog-agent` and put built binaries in `C:\dev\datadog-agent\build`

```dockerfile
docker run -it  \
    -v C:\dev\datadog-agent:C:\gopath\src\github.com\datadog\datadog-agent \
    -v C:\dev\datadog-agent\build:C\.omnibus-ruby \
    squeakysquak/datadog-agent-sdk:go1.12.9-windows-ltsc2019
```