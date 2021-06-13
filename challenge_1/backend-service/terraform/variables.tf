# Backend Config Variables
variable "region" {}

# Set from Jenkinsfile
variable "kpmg_challenge_region" {}
variable "account_environment" {}

# Service Specific Variables
variable "ecs_cluster_id" {}
variable "service_tg_arn" {}
variable "task_family_name" {}
variable "image_name" {}
variable "port" {}
variable "replicas" {}

# Service Specific Environment Variables
variable "backend_service_environment_variable" {}

# Networking
variable "vpc_id" {}
variable "private_subnets" {}

variable "rds_client_sg" {}
variable "ecs_role" {}

