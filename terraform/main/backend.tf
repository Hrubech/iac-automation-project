terraform {
  backend "s3" {
    bucket         = "terraform-backend"   # remplacé automatiquement par le workflow
    key            = "state/terraform.tfstate"
    region         = "us-west-1"
    encrypt        = true
  }
}