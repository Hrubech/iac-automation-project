# IaC & Automatisation — Déploiement AWS avec Terraform + Ansible

## 🎯 Objectif

Ce projet illustre une chaîne d'automatisation complète suivant une approche Infrastructure as Code (IaC) avec Terraform et Ansible.  
Il permet de :
- Déployer une machine virtuelle AWS via Terraform,
- Générer automatiquement un inventaire Ansible,
- Exécuter un playbook Ansible pour configurer la VM (installation d'Apache et déploiement d'une page de test),
- Gérer le cycle de vie (déploiement / destruction) avec un script interactif.

## 🧩 Architecture

![architecture diagram](docs/architecture.png)  

Les composants principaux :
- **Terraform** : provisionne l’infrastructure (EC2, clés SSH, etc.)
- **Ansible** : configure la VM (packages, services, etc.)
- **Scripts Bash** : orchestration complète (menu, vérification, nettoyage)
- **Documentation** : explications techniques & cas d’usage

## 🛠 Prérequis

- Un compte AWS avec des permissions suffisantes.
- AWS CLI configuré (`aws configure`).
- Terraform installé.
- Ansible installé.
- Une paire de clés SSH accessible localement (privée & publique).

## 🚀 Déploiement

1. Clonez ce dépôt :  
   ```bash
   git clone https://github.com/Hrubech/iac-automation-project.git
   cd iac-automation-project
2. Rendez les scripts exécutables :
    ```bash
    chmod +x scripts/*.sh
3. Configurez vos variables AWS si nécessaire dans `terraform/variables.tf` (AMI selon région, etc.).
4. Placez votre clé privée ~/.ssh/automation-key.pem et votre clé publique ~/.ssh/automation-key.pub (ne pas committer la clé privée).
5. Exécutez le script de déploiement :
    ```bash
   bash scripts/deploy.sh
   ```
   Le script initialise Terraform, crée la VM, génère un inventaire Ansible (`inventory.ini`), vérifie la connexion Ansible puis exécute le playbook pour installer Apache et déployer la page de test.
4. Pour détruire l’infrastructure :
    ```bash
   bash scripts/destroy.sh

## 💡 Fonctionnement global

1. **Terraform** : crée une instance EC2 sur AWS et injecte ta clé publique SSH.
2. **Ansible** : utilise la clé privée pour se connecter à la VM et installer Apache.
3. **Apache** : sert une page HTML simple pour valider que le déploiement fonctionne.
4. **Script deploy.sh** : automatise tout (Terraform + Ansible).

## 📦 Structure
```
├── .gitignore
├── README.md
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── provider.tf
├── ansible/
│ ├── inventory_template.ini
│ └── playbook.yml
├── scripts/
│ ├── deploy.sh
│ ├── destroy.sh
│ ├── generate_inventory.sh
│ └── common.sh
└── docs/
    └── architecture.md
```

## 🔐 Sécurité

- Ne jamais committer votre clé privée .pem.
- Le fichier .gitignore inclut les entrées nécessaires pour les exclure.
- Utiliser IAM et rôles minimaux dans AWS.
- Utilisez des variables d'environnement pour les informations sensibles si besoin.

## 💡 Extensions possibles

- Intégration CI/CD (GitHub Actions, GitLab CI)
- Déploiement multi-nœuds (masters + workers)
- Ajout d’options : load balancer, base de données, monitoring
- Gestion de versions Ansible/Terraform via tfenv, ansible-core, etc.

## 🧑‍💻 À propos de l’auteur

Hrubech HOMBESSA — Ingénieur DevOps – Cloud, Automatisation & CI/CD.  
[Suivez moi sur LinkedIn](https://www.linkedin.com/in/hrubech-hombessa/).