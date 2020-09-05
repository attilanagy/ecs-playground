# Terraform module ecs-application

This a [Terraform][terraform] module to deploy a containerized application to an existing [Amazon Elastic Container Service][ecs] cluster. Containers are executed in [AWS Fargate][fargate].

An Application load-balancer is also created by the module.

```
module "web_service" {
  source = "./modules/ecs-application"

  cluster_arn      = aws_ecs_cluster.main.arn
  container_image  = "docker.io/nginx:1.18.0-alpine"
  container_port   = 80
  lb_internal      = false
  lb_listener_port = 80
  lb_network_ids   = module.public_network.network_ids
  name             = "web"
  network_ids      = module.ecs_network.network_ids
  vpc_id           = aws_vpc.main.id

  extra_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
```

## Configuration

See the [variables file](variables.tf) for more details.

## Outputs

The module returns the DNS of the load-balancer. See the [outputs file](outputs.tf) for more details.

[terraform]: https://www.terraform.io/
[ecs]:       https://aws.amazon.com/ecs/
[fargate]:   https://aws.amazon.com/fargate/