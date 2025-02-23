variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "patientservice_image" {
  description = "Docker image for Patient Service"
  type        = string
  default     = "patient-app-a603480f1ae993122cb95270e4ff9a3afbff2ca3"
}

variable "appointmentservice_image" {
  description = "Docker image for Appointment Service"
  type        = string
  default    = "appointment-app-a603480f1ae993122cb95270e4ff9a3afbff2ca3"
}