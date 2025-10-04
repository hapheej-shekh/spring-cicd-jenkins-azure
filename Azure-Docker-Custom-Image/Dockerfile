# syntax=docker/dockerfile:1
FROM ubuntu:22.04

# Prevents apt prompts that would break the build
ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
		ca-certificates \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release \
        bash \
        sudo \
		software-properties-common \
		openjdk-17-jdk \
		git \
        unzip && \
		zip && \
    rm -rf /var/lib/apt/lists/*

	# This keeps your image size smaller
	# rm -rf /var/lib/apt/lists/*


# -------------------------
# Install Docker CLI (Safe + Signed for Ubuntu 22.04+)
# -------------------------
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
      gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*


# Install Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install -y azure-cli && \
    rm -f microsoft.gpg && \
    rm -rf /var/lib/apt/lists/*


# Set kubectl version as build ARG, Commandline arg can override KUBECTL_VERSION
ARG KUBECTL_VERSION=v1.29.4

RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl


# -------------------------
# Install Helm
# -------------------------
ARG HELM_VERSION=v3.14.2
RUN curl -fsSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz && \
    tar -zxvf helm.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf linux-amd64 helm.tar.gz

# -------------------------
# Install Maven CLI
# -------------------------
ARG MAVEN_VERSION=3.9.5
RUN curl -fsSL https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -o maven.tar.gz && \
    tar -xzf maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION}/bin/mvn /usr/bin/mvn && \
    rm maven.tar.gz


# -------------------------
# Set workspace
# -------------------------
WORKDIR /workspace

ENTRYPOINT ["/bin/bash"]



