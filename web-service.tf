module "web_service" {
  source = "./modules/ecs-application"

  cluster_arn      = aws_ecs_cluster.main.arn
  container_image  = "docker.io/nginx:1.18.0-alpine"
  container_port   = 80
  lb_internal      = false
  lb_listener_port = 80
  lb_network_ids   = module.public_network.network_ids
  name             = "web-${var.environment}"
  network_ids      = module.ecs_network.network_ids
  vpc_id           = aws_vpc.main.id

  extra_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
