variable "environment" {
  type        = string
  description = "The name of the enironment."
}

variable "project_name" {
  type        = string
  default     = "ecs-playground"
  description = "The name of the project."
}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "The AWS region where the VPC is located at."
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block of the VPC."
}