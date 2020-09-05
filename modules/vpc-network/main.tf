resource "aws_subnet" "net" {
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet(var.cidr_block, 8, var.range_start + count.index)
  vpc_id            = var.vpc_id

  count = length(var.availability_zones)

  tags = merge({ Name = "${var.name}${count.index}" }, var.extra_tags)
}

resource "aws_route_table_association" "net" {
  route_table_id = var.is_public ? aws_route_table.internet[0].id : aws_route_table.natgw[0].id
  subnet_id      = aws_subnet.net[count.index].id

  count = var.is_public || var.is_nat ? length(var.availability_zones) : 0
}