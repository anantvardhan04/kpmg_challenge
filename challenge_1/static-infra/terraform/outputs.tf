output "rds-password" {
  value = random_password.rds_password.result
}
