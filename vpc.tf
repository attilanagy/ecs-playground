resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-${var.environment}"
    Environment = var.environment
  }
}

module "public_network" {
  source = "./modules/vpc-network"

  availability_zones = data.aws_availability_zones.available.names
  cidr_block         = aws_vpc.main.cidr_block
  is_public          = true
  name               = "${var.project_name}-public-${var.environment}"
  vpc_id             = aws_vpc.main.id

  extra_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

module "ecs_network" {
  source = "./modules/vpc-network"

  availability_zones = data.aws_availability_zones.available.names
  cidr_block         = aws_vpc.main.cidr_block
  is_nat             = true
  name               = "${var.project_name}-ecs-${var.environment}"
  public_network_ids = module.public_network.network_ids[*]
  range_start        = 10
  vpc_id             = aws_vpc.main.id

  extra_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}