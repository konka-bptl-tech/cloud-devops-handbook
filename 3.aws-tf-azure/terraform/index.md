# Terraform Learning Roadmap (Updated with Commands)
## Legend:
* [ ] Not Started
* [/] In Progress
* [x] Completed
---
## 1. What is Infrastructure

* [ ] Definition of Infrastructure
* [ ] On-prem vs Cloud Infrastructure
* [ ] Components of Infrastructure (Compute, Network, Storage)

## 2. What is IaC & Benefits

* [ ] Definition of Infrastructure as Code (IaC)
* [ ] Benefits: Versioning, Reusability, Automation, Consistency
* [ ] Popular IaC Tools (Terraform, CloudFormation, Ansible, Pulumi)

## 3. Terraform Introduction

* [ ] What is Terraform
* [ ] Terraform architecture (CLI, Provider, State)
* [ ] Terraform vs other IaC tools

## 4. Terraform Blocks

* [ ] Provider block
* [ ] Resource block
* [ ] Data block
* [ ] Output block
* [ ] Variable block
* [ ] Locals block
* [ ] Terraform Settings
* [ ] Null Resource

## 5. Terraform Commands

* [ ] `terraform init` – initialize working directory
* [ ] `terraform plan` – preview changes
* [ ] `terraform apply` – apply changes
* [ ] `terraform destroy` – destroy infrastructure
* [ ] `terraform validate` – validate config files
* [ ] `terraform fmt` – format configuration files
* [ ] `terraform taint` / `terraform untaint` – mark resources for recreation
* [ ] `terraform refresh` – reconcile state with real infrastructure
* [ ] `terraform show` – show current state or plan
* [ ] `terraform output` – display outputs
* [ ] `terraform state` – advanced state management (list, mv, rm, pull, push)
* [ ] `terraform graph` – generate visual dependency graph
* [ ] Debugging & Logging (`TF_LOG`, verbose mode)

## 6. Terraform Basic Configuration Files

* [ ] `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`
* [ ] File structure & naming conventions

## 7. Local State & Remote State

* [ ] What is Terraform state
* [ ] Local vs Remote state
* [ ] Backend types (S3, Terraform Cloud, Consul, etc.)
* [ ] Locking & state management
* [ ] Handling resource drift
* [ ] Managing state conflicts in multi-user setups

## 8. Meta-Arguments & Ternary Operator

* [ ] `count`, `for_each`, `depends_on`
* [ ] `lifecycle` meta-argument
* [ ] Ternary operator (`condition ? true_val : false_val`)

## 9. Provisioners

* [ ] `local-exec` & `remote-exec`
* [ ] When to use provisioners
* [ ] Best practices and limitations

## 10. Functions

* [ ] Built-in Terraform functions
* [ ] String, Numeric, Collection functions
* [ ] Interpolation syntax

## 11. Dynamic Block

* [ ] When to use `dynamic` blocks
* [ ] Iterating over lists & maps
* [ ] Example use-cases

## 12. Import

* [ ] `terraform import` basics
* [ ] Importing existing resources
* [ ] Mapping to Terraform state
* [ ] Handling complex dependencies during import

## 13. Workspaces

* [ ] What are workspaces
* [ ] Default vs custom workspaces
* [ ] Managing multiple environments

## 14. Modules

* [ ] What are modules
* [ ] Creating reusable modules
* [ ] Calling modules
* [ ] Input/Output variables in modules
* [ ] Module versioning & registry

## 15. Terragrunt

* [ ] What is Terragrunt
* [ ] Benefits over vanilla Terraform
* [ ] Terragrunt configuration basics
* [ ] Managing remote state & modules with Terragrunt

## 16. Terraform Cloud

* [ ] Introduction to Terraform Cloud
* [ ] Workspaces & VCS integration
* [ ] Remote runs & state management
* [ ] Sentinel Policies & Team Management

## 17. Terraform Versioning & Upgrades

* [ ] Handling Terraform CLI upgrades
* [ ] Provider versioning & compatibility
* [ ] Managing module version upgrades

## 18. Security Best Practices

* [ ] Handling secrets (Vault, SSM Parameter Store, environment variables)
* [ ] IAM & resource access management
* [ ] Security & compliance in Terraform

## 19. CI/CD Integration

* [ ] Terraform pipelines with GitHub Actions / Jenkins / GitLab CI/CD
* [ ] Automating plan, apply, and destroy in pipelines

## 20. Scenario-based Interview Questions (Expanded)

* [ ] Designing multi-tier infrastructure (e.g., web + app + database)
* [ ] Managing multiple environments (dev, staging, prod) efficiently
* [ ] Handling state conflicts in team environments
* [ ] Using modules effectively across projects
* [ ] Managing secrets and sensitive data (Vault, SSM, environment variables)
* [ ] Handling resource drift between Terraform state and actual infrastructure
* [ ] Importing existing resources into Terraform safely
* [ ] Upgrading Terraform CLI or provider versions in a live environment
* [ ] Using `for_each` and `count` for dynamic resource creation
* [ ] Designing CI/CD pipelines for Terraform (plan, apply, destroy automation)
* [ ] Handling remote state locking and preventing race conditions
* [ ] Creating reusable Terraform modules with proper input/output variables
* [ ] Troubleshooting Terraform errors during apply or destroy
* [ ] Managing Terraform Cloud workspaces and VCS integration
* [ ] Using Terragrunt for managing multiple modules and environments
* [ ] Designing infrastructure for high availability and disaster recovery
* [ ] Ensuring security and compliance in Terraform deployments
* [ ] Rolling back infrastructure changes safely
* [ ] Using `dynamic` blocks for variable resources (e.g., security groups with varying rules)
* [ ] Optimizing Terraform plan and apply for large infrastructures
---

