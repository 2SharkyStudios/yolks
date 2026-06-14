FROM        --platform=$TARGETOS/$TARGETARCH ubuntu:jammy

LABEL         author="Kyle Speight" maintainer="chillcog3142@proton.me"

LABEL       org.opencontainers.image.source="https://github.com/2sharkystudios/yolks"
LABEL       org.opencontainers.image.licenses=AGPL

ENV         DEBIAN_FRONTEND=noninteractive

## Install dependencies
RUN apt-get update \
    && apt-get install -y \
        gcc sudo g++ libgcc1 libc++-dev gdb libc6 jq git wget curl tar zip unzip binutils \
        xz-utils liblzo2-2 cabextract iproute2 net-tools netcat-openbsd telnet libatomic1 \
        libsdl1.2debian libsdl2-2.0-0 libfontconfig icu-devtools libunwind8 ca-certificates \
        sqlite3 libsqlite3-dev libzip4 locales ffmpeg apt-transport-https init-system-helpers \
        libcurl3-gnutls liblua5.1-0 libluajit-5.1-2 libsqlite3-0 bzip2 zlib1g libevent-dev \
        libmariadb-dev-compat libmariadb-dev libssl-dev libfluidsynth-dev libicu-dev libssl3 \
        libduktape207 libjsoncpp-dev libleveldb1d libncurses6 libncursesw6 tini \
    && rm -rf /var/lib/apt/lists/*

# Install .NET SDK 9.x (dynamic version detection)
RUN         wget -q https://dot.net/v1/dotnet-install.sh \
            && chmod +x dotnet-install.sh \
            && D_V="$(curl -sSL https://dotnet.microsoft.com/en-us/download/dotnet/9.0 | grep -i '<h3 id="sdk-9.*">SDK 9.*.*</h3>' | head -1 | awk -F\" '{print $3}' | awk '{print $2;}' | sed 's/<\/h3>//g')" \
            && ./dotnet-install.sh -i /usr/share -v "$D_V" \
            && ln -s /usr/share/dotnet /usr/bin/dotnet \
            && rm dotnet-install.sh

# Install PowerShell
RUN mkdir -p /etc/apt/keyrings \
    && apt-get update \
    && apt-get install -y gnupg curl \
    && curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft-prod.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/repos/microsoft-ubuntu-jammy-prod jammy main" > /etc/apt/sources.list.d/microsoft-prod.list \
    && apt-get update \
    && apt-get install -y powershell \
    && rm -rf /var/lib/apt/lists/*