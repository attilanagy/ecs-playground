variable "availability_zones" {
  type        = list(string)
  description = "The AWS availability zones the network is available at."
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block each network has a /24 network in."
}

variable "extra_tags" {
  type        = map
  description = "Key-value pairs each of the resources should be tagged with."
}

variable "is_nat" {
  type        = bool
  default     = false
  description = "Is it a private network with NAT?"
}

variable "is_public" {
  type        = bool
  default     = false
  description = "Is it a public network with internet gateway?"
}

variable "name" {
  type        = string
  description = "The name of the network"
}

variable "public_network_ids" {
  type        = list(string)
  default     = []
  description = "The public network(s) where the NAT gateway is located at."
}

variable "range_start" {
  type        = number
  default     = 0
  description = "The network range starts at this index."
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC."
}