# ZeroTier Installation & Provisioning

This document outlines how to install and provision ZeroTier on Ubuntu 24.04 as part of the provisioning workflow. It uses a secure, repeatable method via the official APT repository.

## Installation Script

The `zerotier_install.sh` script performs the following:

- Checks if ZeroTier is already installed
- Adds the official APT repository and GPG key
- Installs `zerotier-one`
- Prompts the user for a ZeroTier network ID to join
- Verifies network join status via CLI

### Script Location

```bash
scripts/zerotier_install.sh
```

## Notes

- The script supports interactive input for joining a network, making it suitable for post-install provisioning.
- Status is verified using:
  ```bash
  sudo zerotier-cli info
  sudo zerotier-cli listnetworks
  ```

## References

- Official GPG Key:
  [https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg](https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg)
- Official install script (reference only):
  [https://install.zerotier.com/](https://install.zerotier.com/)
- CLI reference:
  [https://docs.zerotier.com/zerotier/cli/network/](https://docs.zerotier.com/zerotier/cli/network/)
