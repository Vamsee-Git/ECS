variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets for ALB"
  type        = list(string)
}

variable "domain_name" {
  description = "Domain name for the services"
  type        = string
}