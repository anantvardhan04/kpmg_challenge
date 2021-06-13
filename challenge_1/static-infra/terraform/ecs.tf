resource "aws_ecs_cluster" "kpmg-challenge-cluster" {
  name = format("kpmg-challenge-%s-%s-cluster", var.account_environment, var.kpmg-challenge_region)
  tags = {
    Name = format("kpmg-challenge-%s-%s-cluster", var.account_environment, var.kpmg-challenge_region)
  }
}