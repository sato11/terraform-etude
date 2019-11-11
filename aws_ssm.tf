resource "aws_ssm_parameter" "db_username" {
  name        = "/db/username"
  value       = "root"
  type        = "String"
  description = "database user"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/db/password"
  value       = "uninitialized!"
  type        = "SecureString"
  description = "database password"
}
