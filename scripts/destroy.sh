#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

cd "$REPO_ROOT/terraform"

echo -e "${RED}Destruction de l'infrastructure Terraform...${NC}"
terraform destroy -auto-approve

# nettoyage
rm -f "$INVENTORY_FILE"

echo -e "${GREEN}Destruction terminée et fichiers nettoyés.${NC}"