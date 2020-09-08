resource "aws_security_group" "lb" {
  name   = "${var.name}-lb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.lb_listener_port
    to_port     = var.lb_listener_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = var.name }, var.extra_tags)
}

resource "aws_lb" "lb" {
  name               = var.name
  internal           = var.lb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets            = var.lb_network_ids
  tags               = merge({ Name = var.name }, var.extra_tags)
}

resource "aws_lb_target_group" "containers" {
  name        = "${var.name}-containers"
  vpc_id      = var.vpc_id
  target_type = "ip"
  port        = var.container_port
  protocol    = "HTTP"
  tags        = merge({ Name = var.name }, var.extra_tags)

  depends_on  = [
    aws_lb.lb
  ]
}

resource "aws_lb_listener" "ecs" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.lb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.containers.arn
  }
}