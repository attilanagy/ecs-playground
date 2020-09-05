resource "aws_security_group" "container" {
  name   = "${var.name}-container-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = var.name }, var.extra_tags)
}

resource "aws_ecs_service" "application" {
  name = var.name

  cluster       = var.cluster_arn
  desired_count = 1
  launch_type   = "FARGATE"

  lifecycle {
    ignore_changes = [desired_count]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.containers.arn
    container_name   = var.name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [aws_security_group.container.id]
    subnets          = var.network_ids
  }


  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.application.arn
}

resource "aws_ecs_task_definition" "application" {
  container_definitions = jsonencode([{
    environment = length(var.container_env) > 0 ? var.container_env : null
    image       = var.container_image
    name        = var.name
    portMappings = [
      {
        containerPort : var.container_port,
        protocol : "tcp"
      }
    ]
  }])
  cpu                      = var.cpu
  family                   = var.name
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}