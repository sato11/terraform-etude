terraform {
  required_version = "0.12.5"

  backend "remote" {
    organization = "terraform-etude"

    workspaces {
      name = "example_workspace"
    }
  }
}

provider "aws" {
  region                  = "eu-central-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
  version                 = "~> 2.35"
}
