resource "aws_key_pair" "automation" {
  key_name   = var.key_name
  public_key = file(var.ssh_public_key_path)
}

# ------------------------------------
# Security Group pour la VM webserver
# ------------------------------------
resource "aws_security_group" "webserver_sg" {
  name        = "webserver-sg"
  description = "Security Group for SSH and HTTP access"
  #vpc_id      = data.aws_vpc.default.id

  # Règle SSH
  ingress {
    description = "SSH depuis poste local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Remplacer par l'IP de votre poste local pour plus de sécurité
  }

  # Règle HTTP — ouverte à tous
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Trafic sortant autorisé
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "webserver-sg"
  }
}

resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.automation.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  tags = {
    Name    = "webserver"
    Project = "iac-webserver"
    Role    = "apache"
  }
}