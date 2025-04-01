#!/bin/bash

set -euo pipefail

# Define Variables
TREZOR_URL="https://data.trezor.io/suite/releases/desktop/latest/Trezor-Suite-25.3.3-linux-x86_64.AppImage"
TREZOR_IMG="Trezor-Suite.AppImage"
SIGNATURE_URL="https://data.trezor.io/suite/releases/desktop/latest/Trezor-Suite-25.3.3-linux-x86_64.AppImage.asc"
SIGNATURE="trezor-suite-25.3.3.AppImage.asc"
SIGNINGKEY_URL="https://trezor.io/security/satoshilabs-2021-signing-key.asc"
SIGNINGKEY="trezor-2021-signing-key.asc"
# Define Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMP_DIR="/tmp/trezor"
INSTALL_DIR="/opt/trezor"
DESKTOP_SRC="$SCRIPT_DIR/../configs/trezor.desktop"
ICON_SRC="$SCRIPT_DIR/../assets/trezor.png"
DESKTOP_DEST="/usr/share/applications/trezor.desktop"
ICON_DEST="/usr/share/pixmaps/trezor.png"

#Download files to temporary directory
mkdir -p "$TEMP_DIR"
echo "[+] Downloading AppImage Signature and Trezor Signing Key"
wget -qO "$TEMP_DIR/$SIGNATURE" "$SIGNATURE_URL"
wget -qO "$TEMP_DIR/$SIGNINGKEY" "$SIGNINGKEY_URL"
wget -qO "$TEMP_DIR/$TREZOR_IMG" "$TREZOR_URL"

# Verify AppImage
echo "[!] Verifying AppImage Integrity..."
cd "$TEMP_DIR"
gpg --import "$SIGNINGKEY"
gpg --verify "$SIGNATURE" "$TREZOR_IMG"

echo "[+] Verification succeeded. Installing Trezor Suite... "
sudo mkdir -p "$INSTALL_DIR"
sudo mv "$TREZOR_IMG" "$INSTALL_DIR/"
sudo chmod +x "$INSTALL_DIR/$TREZOR_IMG"

echo "[+] Installing desktop entry and icon... "

# Copy desktop entry
sudo cp "$DESKTOP_SRC" "$DESKTOP_DEST"

# Copy Icon
sudo cp "$ICON_SRC" "$ICON_DEST"

# Clean up
rm -rf "$TEMP_DIR"

echo "[✓] Trezor Suite installed and integrated. Launch it from your application menu."
