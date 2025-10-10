#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"

# vérifications basiques
command -v terraform >/dev/null 2>&1 || { echo -e "${RED}Terraform manquant${NC}"; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo -e "${RED}Ansible manquant${NC}"; exit 1; }
command -v aws >/dev/null 2>&1 || { echo -e "${RED}AWS CLI manquant${NC}"; exit 1; }

cd "$REPO_ROOT/terraform"

echo -e "${YELLOW}Initialisation Terraform...${NC}"
terraform init -input=false

echo -e "${YELLOW}Création de la VM...${NC}"
terraform apply -auto-approve

# Générer inventaire
bash "$REPO_ROOT/scripts/generate_inventory.sh"

# Vérifier ping
echo -e "${YELLOW}Vérification Ansible ping...${NC}"
ansible -i "$INVENTORY_FILE" webservers -m ping

# Lancer playbook
echo -e "${YELLOW}Exécution du playbook Ansible...${NC}"
ansible-playbook -i "$INVENTORY_FILE" "$REPO_ROOT/ansible/playbook.yml"

echo -e "${GREEN}Déploiement terminé.${NC}"