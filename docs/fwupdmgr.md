# Dell WD19TB Thunderbolt Dock Firmware Update Procedure (Ubuntu + fwupd)

## Overview
This document outlines the tested and validated steps to update the firmware on a **Dell WD19TB Thunderbolt dock** and the **Thunderbolt controller** on a **Dell XPS 13 9310** host system using the `fwupd` utility on Ubuntu.

## Prerequisites
- Host: Dell XPS 13 9310
- Dock: Dell WD19TB
- OS: Ubuntu 24.04.2 (tested)
- `fwupd` installed and configured
- Dell AC power adapter connected to host (not relying on power delivery from dock)

## Preparation
- Ensure the **host system is plugged into AC power on left-hand Thunderbolt port**.
- Connect the **dock to the right-hand Thunderbolt port** on the host.

## Firmware Update: CLI Method

### 1. Refresh metadata
```bash
sudo fwupdmgr refresh --force
```

### 2. List available updates
```bash
fwupdmgr get-updates
```

### 3. Apply updates
```bash
sudo fwupdmgr update
```
This will download and install all applicable firmware updates (e.g., dock firmware, Thunderbolt controller, etc.).

### 4. Activate firmware (if required)
After installation, activation may be required:
```bash
sudo fwupdmgr activate
```
You should see a message confirming activation success. The dock also rebooted automatically for me when when activating updates.

### 5. Reboot host
```bash
sudo reboot
```

### 6. Power cycle the dock
- After reboot, **unplug the dock from the host**.
- **Disconnect the dock from AC power**.
- Wait **15 seconds**, then reconnect power and reattach the dock to the host.

### 7. Verify firmware versions
```bash
fwupdmgr get-devices
```
Confirm that firmware versions (e.g., from 43 → 60) have been correctly updated.

## Firmware Update: GUI Method (for reference)
1. Open **Firmware Updater** (usually available in GNOME Software > Updates tab).
2. Apply all listed updates.
3. Follow any prompts to reboot.
4. Run `fwupdmgr activate` (even when using the GUI method).
5. Reboot the host.
6. After reboot, power cycle the dock as described above.

## Notes
- Activation may not be automatic for Thunderbolt devices.
- Some updates are staged and only completed after a full reboot and peripheral power cycle.
- Always keep the system and dock on AC power during updates to avoid corruption.

## References
- [fwupd Project](https://fwupd.org/)
- `man fwupdmgr`
