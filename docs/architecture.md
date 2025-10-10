# Architecture - IaC Automation Project

Ce document décrit l'architecture et le flux de déploiement.

1. **Terraform** provisionne une instance EC2 dans la région `us-west-1`.
2. Une paire SSH (public key) est envoyée à AWS (resource aws_key_pair).
3. Terraform crée l'instance EC2 avec la keypair attachée.
4. Le script `generate_inventory.sh` récupère l'IP publique via `terraform output` et génère `ansible/inventory.ini`.
5. Ansible utilise la clé privée correspondante (`~/.ssh/automation-key.pem`) pour se connecter et exécuter `playbook.yml`.

Notes de sécurité:
- La clé privée ne doit jamais être committée.
- Utiliser IAM restreint pour Terraform / AWS.