variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "patientservice_image" {
  description = "Docker image for Patient Service"
  type        = string
  default     = "664418994073.dkr.ecr.us-east-1.amazonaws.com/dev-ecr:patient-app-ce71384fe3a47c8a292ab29a2518ab70035a7d52:latest"
}

variable "appointmentservice_image" {
  description = "Docker image for Appointment Service"
  type        = string
  default     = "664418994073.dkr.ecr.us-east-1.amazonaws.com/dev-ecr:appointment-app-ce71384fe3a47c8a292ab29a2518ab70035a7d52:latest"
}

variable "patientservice_target_group_arn" {
  description = "Target Group ARN for Patient Service"
  type        = string
}

variable "appointmentservice_target_group_arn" {
  description = "Target Group ARN for Appointment Service"
  type        = string
}
