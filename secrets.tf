provider "random" {
  version = "~> 2.2"
}

resource "random_string" "db_instance_password" {
  length  = 32
  special = false
}

resource "random_string" "codepipeline_token" {
  length = 32
}
