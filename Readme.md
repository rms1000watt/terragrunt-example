# Terragrunt Example

## Introduction

This is an example Terragrunt setup

## Contents

- [Terraform](#terraform)
- [Setup Developer Machine](#setup-developer-machine)
- [Deploy](#deploy)
- [Modules](#modules)

## Terraform

Terraform allows for Infrastructure as Code. It's important to structure your Terraform directories (and state) to scale with a client's needs. [Terragrunt](https://github.com/gruntwork-io/terragrunt) is wrapper around Terraform that provides many conveniences around developer experience and state management. All `terraform` commands are replaced with `terragrunt` as seen in the `provision.sh` file.

The Terraform directories is designed with this heirarchy:

- Org
- Region
- Environment
- App

This means an org can have multiple regions, and each region can have multple environments, and each environment can have multiple apps. For instance, you can deploy a Jumpbox (app) in each environment in each region in each org. To prevent code duplcation, Terragrunt helps by pointing to a module for each app; each app is just a module or series of modules. These app modules are also maintained at the top level of the Terraform directories.

Here is the current tree:

```
.
├── apps
│   ├── jumpbox
│   │   ├── jumpbox.tf
│   │   ├── out.tf
│   │   ├── remote-state.tf
│   │   ├── ssm.tf
│   │   └── var.tf
│   ├── rds
│   │   ├── local.tf
│   │   ├── out.tf
│   │   ├── rds.tf
│   │   ├── remote-state.tf
│   │   ├── ssm.tf
│   │   └── var.tf
│   └── vpc
│       ├── out.tf
│       ├── var.tf
│       └── vpc.tf
└── orgs
    ├── create-app.sh
    ├── create-org.sh
    ├── main.tf
    └── org-x
        ├── org.tfvars
        ├── terraform.tfvars
        └── us-west-2
            ├── prod
            │   ├── env.tfvars
            │   ├── jumpbox
            │   │   ├── main.tf -> ../../../../main.tf
            │   │   └── terraform.tfvars
            │   ├── rds
            │   │   ├── main.tf -> ../../../../main.tf
            │   │   └── terraform.tfvars
            │   └── vpc
            │       ├── main.tf -> ../../../../main.tf
            │       └── terraform.tfvars
            └── region.tfvars
```

- `orgs` is at the top-most level because a client might have separate AWS Organizations which might segment business units like BizOps, Data Science, Consultants, 3rd Party Clients, etc. which significantly helps with billing. Notice the `terraform.tfvars` file which specifies the org-name and S3 bucket to store the Terraform state
- `apps` is at the top-most level since these are the modules that Terragrunt references
- `orgs/org-x` is the the only organization since this is a simple system. Notice the org.tfvars file which specifies the org name
- `orgs/org-x/us-west-2` is the only region since this is a simple system. Notice the `region.tfvars` file which specifies the region name
- `orgs/org-x/us-west-2/prod` is the only environment since this is a simple system. Notice the `env.tfvars` file which specifies the environment name
- `orgs/org-x/us-west-2/prod/*` these are the apps that are being deployed. The `main.tf` is symlinked back to `orgs/main.tf` since it's the same boilerplate for every app. The exact app module that's being referenced is within `terraform.tfvars`

## Setup Developer Machine

Run the `install.sh` file to install dependent software on your OS X machine:

```bash
./install.sh
```

This will install:

- terraform
- terragrunt
- jq
- awscli
- docker
- sshuttle

[Also, configure the awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html) with config/credentials for `org-x`.

## Deploy

Deploy everything via `provision.sh`. You need to copy, paste, and run the commands. Some commands require running in separate terminal (sshuttle).

```bash
./provision.sh
```

## Future Terraform Development

For future Terraform development, 2 convenience scripts have been created to create orgs and create apps in orgs:

- `terraform/orgs/create-org.sh`
- `terraform/orgs/create-app.sh`

### Create New Org

`vi terraform/orgs/create-org.sh` and change the parameters at the top of the file. Then run

```bash
cd terraform/orgs
./create-org.sh
```

### Create New App

To create a `dev` environment for the `graphql` app in `us-east-1` under the `org-x` org, run:

```bash
cd terraform/orgs
./create-app.sh org-x us-east-1 dev graphql
```

To manage `iam` in `global` under the `org-x` org, run:

```bash
cd terraform/orgs
./create-app.sh org-x global global iam
```

## Modules

Here is a list of Terraform modules used:

- https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/1.40.0
- https://registry.terraform.io/modules/terraform-aws-modules/rds/aws/1.21.0
- https://registry.terraform.io/modules/rms1000watt/easy-sg/aws/0.1.0
- https://registry.terraform.io/modules/rms1000watt/easy-sg/aws/0.2.0
- https://registry.terraform.io/modules/rms1000watt/easy-vm/aws/0.1.0
