@echo off
REM Get the latest stable kubectl version
curl -L -s https://dl.k8s.io/release/stable.txt > version.txt

REM Read the version into a variable
set /p KUBECTL_VERSION=<version.txt

REM Can hardcode version as well as below
REM set KUBECTL_VERSION=v1.29.4

echo Building Docker image with kubectl version %KUBECTL_VERSION%
docker build --build-arg KUBECTL_VERSION=%KUBECTL_VERSION% -t azure-cli-kubectl .

REM Cleanup
del version.txt

REM Run the container interactively
echo Running container from image azure-cli-kubectl...

REM Below command have less arguments
REM docker run -it --rm azure-cli-kubectl

REM Below command will not start jenkins server
docker run -it --rm -v %USERPROFILE%\.kube:/root/.kube azure-cli-kubectl

