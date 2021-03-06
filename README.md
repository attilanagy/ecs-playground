# ECS Playground

This repository contains a simple AWS environment built by [Terraform][terraform]. It demonstrates the usage of [Amazon Elastic Service][ecs].

**Prerequsites**

* Terraform => 0.12
* AWS account

## TL;DR

If you want to build the environment you have to just run the following commands.

```
export AWS_ACCESS_KEY_ID=<your key id comes here>
export AWS_SECRET_ACCESS_KEY=<your secret comes here>
terraform init
terraform workspace select dev
terraform apply -var-file=environments/dev.tfvars
```

## Components

![Diagram](ECSPlayground.png)

There are two local modules to make the environment more flexible.

1. Module [vpc-network](modules/vpc-network/README.md) takes care of the networks in our VPC.
2. Module [ecs-module](modules/ecs-application/README.md) will prepare the ECS service in our cluster.

See the documentation of the modules for more information.

## Configuration

Terraform state is stored in S3. There are some hard-coded values you may want to overwrite in [main.tf](main.tf) file.

| Key    | Value           | Description                                |
|--------|-----------------|--------------------------------------------|
| bucket | s3-playground   | The name of the S3 bucket.                 |
| key    | terraform.state | The name of the state file/object.         |
| region | eu-central-1    | The region where you bucket is located at. |

### Input Variables

Input variables' default values support local development. You can easily overwrite them in the variable files inside the `environments` directory. They belong to the proper CI/CD environment.

## Outputs

Terraform returns the DNS name for each of the defined services. See the [outputs file](outputs.tf) for more details.

## CI/CD

A [Github Actions][githubactions] based CI/CD pipeline is configured. See the `.github/workflows` directory for more details.


[githubactions]: https://github.com/features/actions
[terraform]:     https://www.terraform.io/
[ecs]:           https://aws.amazon.com/ecs/
