# Terraform module vpc-network

This [Terraform][terraform] module creates subnets in the specific availability zones inside an [AWS][aws] VPC.

The following network types are supported.

* **Public** networks are connected to the internet via an *Internet Gateway*.
* **NAT** networks can access the internet via a *NAT Gateway*.
* **Internet** networks are unable to communicate with the outside world.

The following example show how to create a *public* network.

```
module "public_network" {
  source = "./modules/vpc-network"

  availability_zones = var.az_names
  cidr_block         = var.vpc_id
  is_public          = true
  name               = "myPublicNet"
  vpc_id             = aws_vpc.main.id

  extra_tags = {
    Project     = "myProject"
  }
}
```

## Configuration

See the [variables file](variables.tf) for more details.

## Outputs

The module returns the IDs of the created subnets. See the [outputs file](outputs.tf) for more details.

[aws]:       https://aws.amazon.com/
[terraform]: https://www.terraform.io/
