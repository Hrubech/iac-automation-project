#!/bin/bash
set -euo pipefail
source "$(dirname "$0")/common.sh"


cd "$REPO_ROOT/terraform"
WEB_IP=$(terraform output -raw web_public_ip)


cat > "$INVENTORY_FILE" <<EOF
[webservers]
webserver ansible_host=${WEB_IP} ansible_user=ec2-user ansible_ssh_private_key_file=${SSH_KEY_PATH}


[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF


echo -e "${GREEN}Inventaire généré: ${INVENTORY_FILE}${NC}"
cat "$INVENTORY_FILE"