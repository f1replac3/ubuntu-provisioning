#!/bin/bash
#
set -euo pipefail

# Define variables
TELEGRAM_URL="https://telegram.org/dl/desktop/linux"
TELEGRAM_TAR="telegram.tar.xz"
INSTALL_DIR="/opt/Telegram"
BIN_SYMLINK="/usr/local/bin/telegram"
# Handle possible Telegram install directory casing
if [[ -d /opt/telegram ]]; then
    echo "[!] Found existing /opt/telegram (lowercase)."
    EXISTING_DIR="/opt/telegram"
elif [[ -d /opt/Telegram ]]; then
    echo "[!] Found existing /opt/Telegram (uppercase)."
    EXISTING_DIR="/opt/Telegram"
else
    EXISTING_DIR=""
fi
# Download tarbarll
echo "[+] Downloading Telegram tarball..."
wget -qO /tmp/"$TELEGRAM_TAR" "$TELEGRAM_URL"

# Extract tarball
echo "[+] Preparing to extract Telegram to $INSTALL_DIR..."

if [[ -n "$EXISTING_DIR" ]]; then
    read -rp "[?] $EXISTING_DIR already exists. Do you want to reinstall Telegram? [y/N] : " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo "[*] Removing existing installation..."
        sudo rm -rf "$EXISTING_DIR"
        sudo mkdir -p "$INSTALL_DIR"
        sudo tar -xJf "/tmp/$TELEGRAM_TAR" -C "$INSTALL_DIR" --strip-components=1
        sudo chown -R "$USER:$USER" "$INSTALL_DIR"
        echo "[+] Telegram reinstalled to $INSTALL_DIR."
    else
        echo "[!] Skipping extraction. Telegram install aborted."
        exit 0
    fi
else
    sudo mkdir -p "$INSTALL_DIR"
    sudo tar -xJf /tmp/"$TELEGRAM_TAR" -C "$INSTALL_DIR" --strip-components=1
    sudo chown -R "$USER:$USER" "$INSTALL_DIR"
    echo "[+] Telegram installed to $INSTALL_DIR."
fi

# Ask user if they want a symlink
read -rp "[?] Create 'telegram' symlink in /usr/local/bin? [y/N]: "  CREATE_SYMLINK
if [[ "$CREATE_SYMLINK" =~ ^[Yy]$ ]]; then
    echo "[+] Creating symlink at $BIN_SYMLINK..."
    sudo ln -sf "$INSTALL_DIR/Telegram" "$BIN_SYMLINK"
    echo "[+] You can now launch Telegram by typing 'telegram'"
else
    echo "[*] Skipping symlink creation"
fi

# Ask if user wants to delete Telegram user data
read -rp "[?] Do you also want to remove your Telegram user data (this will log you out)? [y/N]: " WIPE_DATA
if [[ "$WIPE_DATA" =~ ^[Yy]$ ]]; then
    echo "[!] Removing ~/.local/share/TelegramDesktop..."
    rm -rf ~/.local/share/TelegramDesktop
    echo "[+] Telegram user data wiped."
else
    echo "[*] User data retained."
fi

echo "[*] Cleaning up..."
sudo rm -f /tmp/"$TELEGRAM_TAR"

echo "[✔] Telegram installation complete."
