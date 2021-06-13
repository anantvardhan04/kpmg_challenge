# CloudWatch Log Group Definition
resource "aws_cloudwatch_log_group" "main" {
  name = format("/ecs/%s/%s/%s", var.frontend-service_region,var.account_environment,var.task_family_name)
}

#Defining template file
data "template_file" "task_def" {
  template = file("task-definitions/service.json")
  vars = {
    image_name = var.image_name
    task_family_name = var.task_family_name
    port = var.port
    region = var.region
    log_group = aws_cloudwatch_log_group.main.name
    backend_service_environment_variables = var.backend_service_environment_variable
  }
}
#ECS Task Definition
resource "aws_ecs_task_definition" "frontend-service_task_def" {
  family                   = format("frontend-service-%s-%s-%s", var.account_environment, var.frontend-service_region, var.task_family_name)
  container_definitions    = data.template_file.task_def.rendered
  execution_role_arn       = var.ecs_role
  task_role_arn            = var.ecs_role
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "service" {
  name            = format("frontend-service-%s-%s-%s-service", var.account_environment, var.frontend-service_region, var.task_family_name)
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.frontend-service_task_def.arn
  desired_count   = var.replicas
  launch_type     = "FARGATE" 
  network_configuration {
    security_groups = [var.rds_client_sg]
    subnets         = var.private_subnets
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = var.service_tg_arn
    container_name   = var.task_family_name
    container_port   = 8090
  }
}
