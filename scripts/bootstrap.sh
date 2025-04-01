#!/bin/bash

set -e

echo "[*] Installing GNOME extensions..."

bash scripts/install_gnome_extensions.sh

bash scripts/telegram_install.sh
