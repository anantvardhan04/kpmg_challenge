# Input variable values for backend state configuration.
bucket = "nagarro-dev-nora-infrastructure-state"
key = "terraform-state/static-infra.tfstate"
region = "us-east-1"

# Generic
account_environment = "ng-dev"
nagarro_region = "nora"

# Networking
vpc_id = "vpc-09945915a88781c3f"

private_subnets = [
  "subnet-097a4081213284c4d",
  "subnet-06ceccf6431a3ec73"
]

public_subnets = [
  "subnet-0cbfebf1601adfe4c",
  "subnet-0a0f2fd1d1ea751c9"
]

#alb_certificate = ""

rds_storage_encrypted = "true"
rds_cluster_instance_number = 1
rds_cluster_instance_class = "db.t2.small"
