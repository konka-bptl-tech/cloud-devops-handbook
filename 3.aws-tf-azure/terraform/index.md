# Terraform Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. What is Infrastructure
- [ ] Definition of Infrastructure
- [ ] On-prem vs Cloud Infrastructure
- [ ] Components of Infrastructure (Compute, Network, Storage)

## 2. What is IaC & Benefits
- [ ] Definition of Infrastructure as Code (IaC)
- [ ] Benefits: Versioning, Reusability, Automation, Consistency
- [ ] Popular IaC Tools (Terraform, CloudFormation, Ansible, Pulumi)

## 3. Terraform Introduction
- [ ] What is Terraform
- [ ] Terraform architecture (CLI, Provider, State)
- [ ] Terraform vs other IaC tools

## 4. Terraform Blocks
- [ ] Provider block
- [ ] Resource block
- [ ] Data block
- [ ] Output block
- [ ] Variable block
- [ ] Locals block
- [ ] Terraform backend block

## 5. Terraform Commands
- [ ] `terraform init`
- [ ] `terraform plan`
- [ ] `terraform apply`
- [ ] `terraform destroy`
- [ ] `terraform validate`
- [ ] `terraform fmt`
- [ ] `terraform taint` / `terraform untaint`

## 6. Terraform Basic Configuration Files
- [ ] `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`
- [ ] File structure & naming conventions

## 7. Local State & Remote State
- [ ] What is Terraform state
- [ ] Local vs Remote state
- [ ] Backend types (S3, Terraform Cloud, Consul, etc.)
- [ ] Locking & state management

## 8. Meta-Arguments & Ternary Operator
- [ ] `count`, `for_each`, `depends_on`
- [ ] `lifecycle` meta-argument
- [ ] Ternary operator (`condition ? true_val : false_val`)

## 9. Provisioners
- [ ] `local-exec` & `remote-exec`
- [ ] When to use provisioners
- [ ] Best practices and limitations

## 10. Functions
- [ ] Built-in Terraform functions
- [ ] String, Numeric, Collection functions
- [ ] Interpolation syntax

## 11. Dynamic Block
- [ ] When to use `dynamic` blocks
- [ ] Iterating over lists & maps
- [ ] Example use-cases

## 12. Import
- [ ] `terraform import` basics
- [ ] Importing existing resources
- [ ] Mapping to Terraform state

## 13. Workspaces
- [ ] What are workspaces
- [ ] Default vs custom workspaces
- [ ] Managing multiple environments

## 14. Modules
- [ ] What are modules
- [ ] Creating reusable modules
- [ ] Calling modules
- [ ] Input/Output variables in modules
- [ ] Module versioning & registry

## 15. Terragrunt
- [ ] What is Terragrunt
- [ ] Benefits over vanilla Terraform
- [ ] Terragrunt configuration basics
- [ ] Managing remote state & modules with Terragrunt

## 16. Terraform Cloud
- [ ] Introduction to Terraform Cloud
- [ ] Workspaces & VCS integration
- [ ] Remote runs & state management
- [ ] Sentinel Policies & Team Management

## 17. Scenario-based Interview Questions
- [ ] Designing multi-tier infra
- [ ] Managing multiple environments
- [ ] Handling state conflicts
- [ ] Using modules effectively
- [ ] Security & compliance in Terraform
