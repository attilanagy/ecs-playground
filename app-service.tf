module "app_service" {
  source = "./modules/ecs-application"

  cluster_arn = aws_ecs_cluster.main.arn
  container_env = [
    {
      name  = "NODE_ENV"
      value = var.environment
    }
  ]
  container_image  = "docker.io/bitnami/node-example:0.0.1"
  container_port   = 3000
  lb_internal      = false
  lb_listener_port = 80
  lb_network_ids   = module.public_network.network_ids
  name             = "app-${var.environment}"
  network_ids      = module.ecs_network.network_ids
  vpc_id           = aws_vpc.main.id

  extra_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
