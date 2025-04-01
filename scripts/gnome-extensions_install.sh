#!/usr/bin/env bash
# install_gnome_extensions.sh
# Sets up GNOME Shell extensions from source into ~/.local/share/gnome-shell/extensions

set -euo pipefail

echo "[INFO] Installing required system packages..."
sudo apt update
sudo apt install -y gnome-shell-extensions gettext ddcutil

echo "[INFO] Ensuring GNOME extensions directory exists..."
mkdir -p ~/.local/share/gnome-shell/extensions
mkdir -p ~/src/gnome-extensions
cd ~/src/gnome-extensions

# 1. GNOME Display Brightness (DDC/CI)
echo "[INFO] Installing DDC/CI Brightness extension..."

# Kernel module and group setup
sudo groupadd --system i2c || true
sudo usermod -aG i2c "$USER"
sudo modprobe i2c-dev
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c.conf > /dev/null

# Udev rule
if [ -f /usr/share/ddcutil/data/45-ddcutil-i2c.rules ]; then
  sudo cp /usr/share/ddcutil/data/45-ddcutil-i2c.rules /etc/udev/rules.d/
else
  echo "[WARN] ddcutil udev rule not found — skipping."
fi

# Clone and build
git clone https://github.com/daitj/gnome-display-brightness-ddcutil.git ddcutil@daitj.github.com
cd ddcutil@daitj.github.com
make build
cp -r display-brightness-ddcutil@themightydeity.github.com ~/.local/share/gnome-shell/extensions/
gnome-extensions enable display-brightness-ddcutil@themightydeity.github.com
cd ..

# 2. Clipboard Indicator
echo "[INFO] Installing Clipboard Indicator extension..."

git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git clipboard-indicator@tudmotu.com
cp -r clipboard-indicator@tudmotu.com ~/.local/share/gnome-shell/extensions/
gnome-extensions enable clipboard-indicator@tudmotu.com

# 3. Argos Extension
echo "[INFO] Installing Argos extension..."

git clone https://github.com/p-e-w/argos.git argos@pew.worldwidemann.com
cp -r argos@pew.worldwidemann.com ~/.local/share/gnome-shell/extensions/
gnome-extensions enable argos@pew.worldwidemann.com

# Setup Argos config from ubuntu-provisioning/config 

echo "[INFO] Setting up Argos extensions"

# Ensure destination exists
mkdir -p ~/.config/argos

# Copy or symlink (default is copy)

# Copy files
cp -r ../configs/argos/* ~/.config/argos/

# symlink option
# ln -sf "$(pwd)/../configs/argos/"* ~/.config/argos/
#
# Set executable perms
chmod +x ~/.config/argos/*.sh

echo "[DONE] GNOME Shell extensions installed and enabled."
echo "⚠️ You may need to restart GNOME Shell or log out/in for full activation."
