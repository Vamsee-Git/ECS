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
}

variable "appointmentservice_image" {
  description = "Docker image for Appointment Service"
  type        = string
}

variable "patientservice_target_group_arn" {
  description = "Target Group ARN for Patient Service"
  type        = string
}

variable "appointmentservice_target_group_arn" {
  description = "Target Group ARN for Appointment Service"
  type        = string
}
