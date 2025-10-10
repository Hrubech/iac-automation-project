resource "aws_key_pair" "automation" {
    key_name = var.key_name
    public_key = file(var.ssh_public_key_path)
}

resource "aws_instance" "webserver" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = aws_key_pair.automation.key_name

    tags = {
        Name = "iac-automation-webserver"
    }
}