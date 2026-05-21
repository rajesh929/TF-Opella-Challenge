# Terraform Azure Infrastructure

## About This Project

This project is created using Terraform to deploy Azure infrastructure.

In the project we are creating: 
- Resource Group
- Virtual Network (VNET)
- Subnets
- Network Interface
- Linux Virtual Machine

---

## Folder Structure

```text
OpellaChallenge/

├── tf-envs/
│   ├── dev/
│   └── prod/
│
├── modules/
│   └── virtual-network/
│
├── .github/workflows/
│   └── tf-plan-and-deploy.yml
│
└── README.md
```

---

## Reusable Module

We have created a module for Azure Virtual Netwrok inside:

```text
modules/virtual-network
```

This module can be reused for different environments.

---

## Environments

We have two environments
- dev 
- prod 

Both environments use different:
- names
- tags

---

## Terraform Commands

Login to Azure:

```bash
az login
```

Initialize Terraform:

```bash
terraform init
```

Validate Terraform:

```bash
terraform validate
```

Terraform Plan:

```bash
terraform plan
```

Terraform Apply:

```bash
terraform apply
```

---

## GitHub Actions

We have a GitHub Actions pipeline for deploying this infrastructure into Azure, and the pipeline execute below Terraform tasks:
- terraform init
- terraform validate
- terraform plan
- terraform deploy

This pipeline needs Azure credentials like
- Tenant Id
- Subscriptions Id
- Client Id
- Client Secret

Please add the above values in GitHub repo secrets so that the pipeline can refer them. 

Pipeline file:

```text
.github/workflows/tf-plan-and-deploy.yml
```

---

## Good Practices Used

- reusable Terraform code
- separate environments
- tags
- clean folder structure

---

## Terraform Plan Output

Terraform plan output is added in:

```text
tf-plan.txt
```