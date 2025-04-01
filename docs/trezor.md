# Trezor Suite Installation & Desktop Integration

This document describes the process for provisioning Trezor Suite on a fresh Ubuntu installation.

---

## 🔧 Overview

- **AppImage** is downloaded from the official source
- **GPG Verification** is performed using Trezor's 2021 signing key
- **AppImage is moved to** `/opt/trezor`
- **Executable permissions** are set
- **Desktop entry** and **icon** are copied for application launcher integration
- **Udev rules** are installed for USB access

---

## 📁 Files & Resources

| Resource       | URL |
|----------------|-----|
| AppImage       | https://data.trezor.io/suite/releases/desktop/latest/Trezor-Suite-25.3.3-linux-x86_64.AppImage |
| Signature      | https://data.trezor.io/suite/releases/desktop/latest/Trezor-Suite-25.3.3-linux-x86_64.AppImage.asc |
| Signing Key    | https://trezor.io/security/satoshilabs-2021-signing-key.asc |
| Udev Rules     | https://data.trezor.io/udev/trezor-udev_2_all.deb |

---

## 🧩 Install Script

See [`scripts/trezor_install.sh`](../scripts/trezor_install.sh)

---

## 📂 Desktop Entry

Stored in [`configs/trezor.desktop`](../configs/trezor.desktop). Installed to:

```bash
/usr/share/applications/trezor.desktop
```

Ensure this entry contains:

```ini
[Desktop Entry]
Name=Trezor Suite
Exec=/opt/trezor/Trezor-Suite.AppImage --no-sandbox
Icon=/usr/share/pixmaps/trezor.png
Type=Application
Categories=Finance;
StartupNotify=true
StartupWMClass=Trezor Suite
```

---

## 🖼️ Icon

Stored in [`assets/trezor.png`](../assets/trezor.png). Installed to:

```bash
/usr/share/pixmaps/trezor.png
```

---

## 🔐 Udev Rules

Install with:

```bash
sudo apt install ./trezor-udev_2_all.deb
```

After installation, Trezor devices should be usable via USB without needing `sudo`.

---

## ❗ Notes

- The `--no-sandbox` flag is required if you encounter Chromium sandbox errors.
- GPG signature verification is manual but integrated in the install script.
- Do **not** forget to `chmod +x` the AppImage after moving it.

