Directory Contents


**backend-service** -> Terraform resources and configuration for deploying the backend service

**frontend-service** -> Terraform resources and configuration for deploying the frontend service

**static-infra** -> Terraform resources and configuration for deploying the infrastructure for our application

backend-service (**_Logic Layer_**)
- ECS service resource 
- ECS Task Definition 

frontend-service (**_Presenation Layer_**)
- ECS service resource 
- ECS Task Definition 

static-infra (**_RDS will make up the Data Layer_**)
- alb : Public facing loadbalancer
- ecr : ECR reposiotry to push the Docker images for backend-service and frontend-service
- ecs : Elastic Container Service instance
- rds : RDS Aurora instance to which our backend service will get connected


