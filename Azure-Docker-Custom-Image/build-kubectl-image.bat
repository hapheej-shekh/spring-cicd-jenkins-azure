@echo off
REM Get the latest stable kubectl version
curl -L -s https://dl.k8s.io/release/stable.txt > version.txt

REM Read the version into a variable
set /p KUBECTL_VERSION=<version.txt

echo Building Docker image with kubectl version %KUBECTL_VERSION%
docker build --build-arg KUBECTL_VERSION=%KUBECTL_VERSION% -t azure-cli-kubectl .

REM Cleanup
del version.txt
