output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.ecs_cluster_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.ecr_repository_url
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}