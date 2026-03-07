#!/bin/bash
# SSH configuration variables

# Machine identification
HOSTNAME=$(cat /etc/hostname 2>/dev/null || echo "unknown")

# 1Password configuration
ONEPASSWORD_ITEM="ssh-key-${HOSTNAME}"
ONEPASSWORD_FIELD="password"

# YubiKey challenge-response configuration
# Includes hostname so each machine derives a unique challenge without any stored state
CHALLENGE="ssh-key-passphrase-$(whoami)-${HOSTNAME}"

# Location of encrypted passphrase file (for YubiKey method)
PASSPHRASE_FILE="$HOME/.ssh/.passphrase.enc"

# SSH key location
SSH_KEY="$HOME/.ssh/id_ed25519"
