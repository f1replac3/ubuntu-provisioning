#!/bin/bash
set -euo pipefail

echo "[*] Checking for existing ZeroTier installation..."

if command -v zerotier-cli &>/dev/null; then
    echo "[✓] ZeroTier is already installed. Skipping installation."
    exit 0
fi

# Add ZeroTier GPG key and repository
echo "[*] Adding ZeroTier APT repository and key..."
curl -fsSL https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg | \
  gpg --dearmor | sudo tee /usr/share/keyrings/zerotier-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/zerotier-archive-keyring.gpg] http://download.zerotier.com/debian/noble noble main" | \
  sudo tee /etc/apt/sources.list.d/zerotier.list

# Install ZeroTier
echo "[*] Updating APT and installing zerotier-one..."
sudo apt update
sudo apt install -y zerotier-one

# Enable and start the service
echo "[*] Enabling and starting ZeroTier service..."
sudo systemctl enable zerotier-one
sudo systemctl start zerotier-one

# Prompt user to join a network
read -rp "[?] Enter your ZeroTier Network ID to join (or leave blank to skip): " NETWORK_ID
if [[ -n "$NETWORK_ID" ]]; then
    sudo zerotier-cli join "$NETWORK_ID"
    echo "[*] attempting to join ZeroTier network... "

    sleep 5 

    echo "[*] ZeroTier service status: "
    sudo zerotier-cli info

    echo "[*] Network membership: "
    sudo zerotier-cli listnetworks | grep "$NETWORK_ID" || echo "[!] Could not verify network join"
fi

echo "[✓] ZeroTier installation complete."
