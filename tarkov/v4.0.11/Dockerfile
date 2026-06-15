FROM        --platform=$TARGETOS/$TARGETARCH ghcr.io/2sharkystudios/base:ubuntu

LABEL       author="Kyle Speight" maintainer="postmaster@terraforge.fun"

ENV         DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN         apt-get update \
            && apt-get install -y ca-certificates gnupg lsb-release wget curl iproute2 libgdiplus tini \
            && rm -rf /var/lib/apt/lists/*

# Install .NET SDK 9.x (dynamic version detection)
RUN         wget -q https://dot.net/v1/dotnet-install.sh \
            && chmod +x dotnet-install.sh \
            && D_V="$(curl -sSL https://dotnet.microsoft.com/en-us/download/dotnet/9.0 | grep -i '<h3 id="sdk-9.*">SDK 9.*.*</h3>' | head -1 | awk -F\" '{print $3}' | awk '{print $2;}' | sed 's/<\/h3>//g')" \
            && ./dotnet-install.sh -i /usr/share -v "$D_V" \
            && ln -s /usr/share/dotnet /usr/bin/dotnet \
            && rm dotnet-install.sh

# Install PowerShell
RUN         mkdir -p /etc/apt/keyrings \
            && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft-prod.gpg \
            && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-jammy-prod jammy main" > /etc/apt/sources.list.d/microsoft-prod.list \
            && apt-get update \
            && apt-get install -y powershell \
            && rm -rf /var/lib/apt/lists/*

WORKDIR     /home/container/

USER        container
ENV         USER=container HOME=/home/container

RUN         chmod +x /entrypoint.sh

STOPSIGNAL SIGINT

ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]