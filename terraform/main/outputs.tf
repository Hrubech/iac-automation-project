output "web_public_ip" {
    description = "Adresse IP publique de la VM web"
    value = aws_instance.webserver.public_ip
}

output "web_private_ip" {
    description = "Adresse IP privée de la VM web"
    value = aws_instance.webserver.private_ip
}