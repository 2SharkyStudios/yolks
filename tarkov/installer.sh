#!/bin/bash

# ==========================================
# SPT Server Build Script
# ==========================================
# Target: Installs dependencies and builds binaries directly to /home/container
# ==========================================

echo ">>> Starting SPT Server Build Setup..."

# 1. Create Directory Structure
echo "[1/7] Creating directory structure..."
mkdir -p /home/container/git
mkdir -p /home/container/build

# 2. Update and Install Base Dependencies
echo "[2/7] Updating package lists and installing base dependencies..."
apt-get update
apt-get install -y ca-certificates gnupg lsb-release wget curl git git-lfs iproute2 libgdiplus tini software-properties-common

# 5. Clone Repository
echo "[3/7] Cloning SPT-Server-Build repository..."
cd /home/container/git
git clone https://github.com/2SharkyStudios/SPT-Server-Build.git .
git lfs pull

# 6. Build the Project
echo "[4/7] Building SPT Server (Release Mode)..."
cd /home/container/git/SPTarkov.Server/

# Output directly to /home/container/
dotnet restore
dotnet build -o /home/container/ -c Release -p:SptBuildType=RELEASE -p:SptVersion=4.0.11

# Change ownership of the build directory to the 'container' user
chown -R container:container /home/container

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /home/container/git/

echo ">>> Setup Complete!"
echo "Binaries are located in: /home/container/"
echo "You can now switch to the 'container' user and run your server:"
echo "  su - container"
echo "  cd /home/container"
echo "  ./SPT.Server"