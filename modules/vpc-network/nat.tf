resource "aws_eip" "natgw" {
  count = var.is_nat ? length(aws_subnet.net[*]) : 0
  vpc   = true

  tags = merge({ Name = "${var.name}-natgw-${count.index}" }, var.extra_tags)
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw[count.index].id
  subnet_id     = var.public_network_ids[count.index]

  count = var.is_nat ? length(var.availability_zones) : 0

  tags = merge({ Name = "${var.name}-natgw-${count.index}" }, var.extra_tags)
}

resource "aws_route_table" "natgw" {
  vpc_id = var.vpc_id
  count  = var.is_nat ? length(aws_subnet.net[*]) : 0

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw[count.index].id
  }

  tags = merge({ Name = "${var.name}-natgw-nat${count.index}" }, var.extra_tags)
}