variable "aws_region" {
    description = "Région AWS"
    type = string
    default = "us-west-1"
}

variable "key_name" {
    description = "Nom de la keypair AWS"
    type = string
    default = "automation-key"
}

variable "ssh_public_key_path" {
    description = "Chemin vers la clé publique SSH locale"
    type = string
    default = "~/.ssh/automation-key.pub"
}

variable "instance_type" {
    description = "Type d'instance EC2"
    type = string
    default = "t3.micro"
}

variable "ami_id" {
    description = "AMI ID à utiliser (Amazon Linux 2023 kernel-6.1)"
    type = string
    default = "ami-0b967c22fe917319b" # exemple; adapte selon région
}