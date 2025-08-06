terraform {
  backend "s3" {
    bucket         = "aryan-iac-lab-tfstate"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    use_lockfile   = true
  }
}