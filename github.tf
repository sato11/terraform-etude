provider "github" {
  organization = "sato11"
  version      = "~> 2.2"
}

resource "github_repository_webhook" "example" {
  repository = "terraform-etude"

  configuration {
    url          = aws_codepipeline_webhook.example.url
    secret       = random_string.codepipeline_token.result
    content_type = "json"
    insecure_ssl = false
  }

  events = ["push"]
}
