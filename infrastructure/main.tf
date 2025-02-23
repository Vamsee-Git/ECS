#Terraform lock
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  hash_key     = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    bucket         = "sneha-terraform-bucket"
    key            = "ec2-instance/usecase3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}


module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  environment    = var.environment
}

module "ecr" {
  source = "./modules/ecr"

  environment         = var.environment
}

module "ecs" {
  source = "./modules/ecs"

  vpc_id               = module.vpc.vpc_id  # Pass the VPC ID to the ECS module
  private_subnets      = module.vpc.private_subnets
  environment          = var.environment
  patientservice_target_group_arn = module.alb.patientservice_target_group_arn
  appointmentservice_target_group_arn = module.alb.appointmentservice_target_group_arn
  patientservice_image = var.patientservice_image
  appointmentservice_image = var.appointmentservice_image
}

module "alb" {
  source             = "./modules/alb"
  environment        = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  domain_name        = module.alb.alb_dns_name
}
