variable "cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster this app belongs to."
}

variable "cpu" {
  type        = string
  default     = "256"
  description = "The hard-limit 0f CPU usage."
}

variable "container_env" {
  type        = list
  default     = []
  description = "The list of environment variables of the container."
}

variable "container_image" {
  type        = string
  description = "The name of the container image."
}

variable "container_port" {
  type        = number
  description = "The port the service listens on inside the container."
}

variable "extra_tags" {
  type        = map
  description = "Key-value pairs each of the resources should be tagged with."
}

variable "lb_internal" {
  type        = bool
  default     = true
  description = "Is the load-balancer internal only?"
}

variable "lb_listener_port" {
  type        = number
  description = "The port the load-balancer is accisable at."
}

variable "lb_network_ids" {
  type        = list(string)
  description = "The IDs of networks the LB should be located at."
}

variable "memory" {
  type        = string
  default     = "512"
  description = "The memory hard-limit in Megabytes."
}

variable "name" {
  type        = string
  description = "The name of the application hosed on ECS."
}

variable "network_ids" {
  type        = list(string)
  description = "The IDs of the networks where the containers should be running in."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
}