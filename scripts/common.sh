#!/bin/bash
set -euo pipefail


# Couleurs
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m"


REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SSH_KEY_NAME="automation-key"
SSH_KEY_PATH="$HOME/.ssh/${SSH_KEY_NAME}"
INVENTORY_FILE="$REPO_ROOT/ansible/inventory.ini"