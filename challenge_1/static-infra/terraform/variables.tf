variable "region" {}
variable "account_environment" {}
variable "kpmg_challenge_region" {}

# Network
variable "vpc_id" {}
variable "public_subnets" {}
variable "private_subnets" {}
# variable "alb_certificate" {}

# RDS
variable "rds_storage_encrypted" {}
variable "rds_cluster_instance_number" {}
variable "rds_cluster_instance_class" {}
