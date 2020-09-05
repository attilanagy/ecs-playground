resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  tags   = merge({ Name = "${var.name}-gw" }, var.extra_tags)

  count = var.is_public ? 1 : 0
}

resource "aws_route_table" "internet" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }

  tags = merge({ Name = var.name }, var.extra_tags)

  count = var.is_public ? 1 : 0
}