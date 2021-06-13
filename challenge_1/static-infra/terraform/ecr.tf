resource "aws_ecr_repository" "kpmg-challenge-backend-service" {
  name = format("kpmg-challenge-%s-%s-backend-svc", var.account_environment, var.kpmg-challenge_region)
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "kpmg-challenge-frontend-service" {
  name = format("kpmg-challenge-%s-%s-frontend-svc", var.account_environment, var.kpmg-challenge_region)
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_iam_role" "kpmg-challenge-ecs-task-role" {
  name = format("kpmg-challenge-%s-%s-ecs-tasks", var.account_environment, var.kpmg-challenge_region)
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "kpmg-challenge-ecs-task-role-attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role = aws_iam_role.kpmg-challenge-ecs-task-role.name
}