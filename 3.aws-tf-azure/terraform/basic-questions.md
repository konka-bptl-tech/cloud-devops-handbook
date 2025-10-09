## 🧠 Terraform Commands – Hands-On Scenarios

### **1. You modified a resource manually in AWS. How do you make Terraform reflect the real state?**

**Problem:** State file is outdated (drift).
**Solution:**

```bash
terraform refresh
terraform plan
```

**Explanation:**
`terraform refresh` updates the local state file with real infrastructure data — it won’t change actual resources.

---

### **2. You want to recreate only one EC2 instance without touching others.**

**Solution 1 (Mark for recreation):**

```bash
terraform taint aws_instance.app_server
terraform apply
```

**Solution 2 (Target apply):**

```bash
terraform apply -target=aws_instance.app_server
```

**Interview Tip:**
Use `taint` if you want Terraform to delete & recreate a resource during apply.
Use `-target` when you want to apply or destroy a specific resource only.

---

### **3. You added new resources but provider plugins are old.**

**Solution:**

```bash
terraform init -upgrade
```

**Explanation:**
This re-downloads the latest provider versions and upgrades dependencies.

---

### **4. You need to check all resources currently tracked by Terraform.**

**Solution:**

```bash
terraform state list
```

**Extra:**
Use `terraform state show <resource>` to inspect a specific one.

---

### **5. You deleted an AWS resource manually, but it still shows in Terraform state.**

**Solution:**

```bash
terraform state rm aws_s3_bucket.demo
```

**Explanation:**
Removes resource from Terraform tracking without deleting anything in the cloud.

---

### **6. You migrated a resource from one module to another.**

**Solution:**

```bash
terraform state mv 'module.old.aws_instance.web' 'module.new.aws_instance.web'
```

**Explanation:**
Keeps the state consistent during refactoring.

---

### **7. You want to import an existing AWS resource into Terraform.**

**Solution:**

```bash
terraform import aws_s3_bucket.demo demo-bucket
```

**Steps:**

1. Create resource block in `.tf` file (no apply yet).
2. Run import command.
3. Run `terraform plan` to verify state alignment.

---

### **8. You want to visualize resource dependencies.**

**Solution:**

```bash
terraform graph | dot -Tpng > graph.png
```

**Explanation:**
Generates a graph of how your resources depend on each other (uses Graphviz).

---

### **9. You want to validate and format all Terraform files before pushing to GitHub.**

**Solution:**

```bash
terraform validate
terraform fmt -recursive
```

**Tip:**
These are great to include in CI/CD pipelines.

---

### **10. You want to debug why Terraform apply is failing.**

**Solution:**

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=./terraform.log
terraform apply
```

**Explanation:**
Logs all backend and provider interactions — useful for troubleshooting.

---

### **11. You only want to see output values like instance IP or DB endpoint.**

**Solution:**

```bash
terraform output
terraform output db_endpoint
```

**Use case:**
CI/CD pipelines often use these outputs for deployments or notifications.

---

### **12. You want to destroy everything but confirm changes before.**

**Solution:**

```bash
terraform plan -destroy
terraform destroy
```

**Explanation:**
`plan -destroy` previews what will be deleted — safer for production.

---

### **13. You want to apply changes only for one module (e.g., VPC).**

**Solution:**

```bash
terraform apply -target=module.vpc
```

**Tip:**
Use carefully — it skips dependency checks.

---

### **14. You want to format and clean your Terraform code base automatically.**

**Solution:**

```bash
terraform fmt -recursive
```

**Optional in CI/CD:**
Add it to pre-commit hook or GitHub Action.

---

### **15. You want to know the difference between `refresh` and `plan`.**

| Command             | Purpose                                                         |
| ------------------- | --------------------------------------------------------------- |
| `terraform refresh` | Syncs **state file** with real infra (no plan or apply).        |
| `terraform plan`    | Shows **differences** between desired (code) and current state. |
| Combined usage      | `terraform refresh && terraform plan` = full drift detection.   |

---

## 🧩 Terraform Real-World Scenarios (Set 3 – Advanced)

---

### **31. You have multiple environments (dev, stage, prod). How do you manage them efficiently?**

**Problem:**
You don’t want to duplicate `.tf` files for every environment.

**Solution Options:**

1. **Workspaces:**

   ```bash
   terraform workspace new dev
   terraform workspace select prod
   ```

   Variables change per workspace.

2. **Separate tfvars files:**

   ```
   terraform apply -var-file=dev.tfvars
   terraform apply -var-file=prod.tfvars
   ```

3. **Terragrunt:**

   ```hcl
   include { path = find_in_parent_folders() }
   terraform {
     source = "../modules/vpc"
   }
   inputs = {
     environment = "prod"
   }
   ```

**Best Practice:**
Use Terragrunt for environment separation and DRY (Don’t Repeat Yourself) architecture.

---

### **32. You got a “state lock already held” error during apply. What do you do?**

**Problem:**
Terraform is locked because of an incomplete or failed operation.

**Solution:**

* If using DynamoDB (S3 backend):

  ```bash
  terraform force-unlock <LOCK_ID>
  ```
* Find the lock ID from the error message.

**Tip:**
Never force unlock if another apply is still running.

---

### **33. You want to automatically trigger Terraform apply after merging code to `main` branch.**

**Solution:**
Use a **CI/CD pipeline (GitHub Actions / Jenkins)**:

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
      - run: terraform init
      - run: terraform plan
      - run: terraform apply -auto-approve
```

**Explanation:**
Integrates Terraform into your DevOps workflow for automation.

---

### **34. You want to share Terraform modules across your team with versioning.**

**Solution:**
Publish modules to **Terraform Registry** or **private Git repository**:

```hcl
module "vpc" {
  source  = "git::https://github.com/konka/modules.git//vpc?ref=v1.0.2"
}
```

**Explanation:**
Version control helps you track and roll back module updates easily.

---

### **35. You want to upgrade a Terraform provider version safely.**

**Solution:**

1. Update version constraint:

   ```hcl
   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = "~> 5.0"
     }
   }
   ```
2. Run:

   ```bash
   terraform init -upgrade
   terraform plan
   ```
3. Review plan before applying.

**Explanation:**
The `~>` operator ensures safe minor upgrades.

---

### **36. You changed a Terraform module, but nothing changes after apply.**

**Possible causes:**

* Module version not bumped (cached version used)
* Missing `terraform init -upgrade`
* Variables not connected properly

**Solution:**

```bash
terraform init -upgrade
terraform plan
```

**Tip:**
Always bump module version or use `-upgrade` to fetch new code.

---

### **37. You’re getting “resource already exists” error during apply.**

**Problem:**
Terraform tries to create a resource that already exists in the cloud.

**Solution:**

1. Import it:

   ```bash
   terraform import aws_s3_bucket.logs konka-logs
   ```
2. Then run:

   ```bash
   terraform plan
   ```

**Explanation:**
Import brings existing resources under Terraform management.

---

### **38. You’re migrating Terraform state from local to remote backend.**

**Solution:**

```bash
terraform init -migrate-state
```

**Explanation:**
This moves your existing `terraform.tfstate` to the remote backend (like S3).

---

### **39. You want to automatically format and validate Terraform files during every commit.**

**Solution:**
Add a **pre-commit hook**:

```yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.78.0
    hooks:
      - id: terraform_fmt
      - id: terraform_validate
```

**Explanation:**
Ensures Terraform code is clean and valid before it reaches Git.

---

### **40. You need to use outputs from one Terraform project in another (e.g., VPC → EKS).**

**Solution:**

* Export outputs from Project A to S3 or Terraform Cloud.
* Use `terraform_remote_state` in Project B:

  ```hcl
  data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
      bucket = "konka-tf-state"
      key    = "vpc/terraform.tfstate"
      region = "ap-south-1"
    }
  }

  resource "aws_eks_cluster" "main" {
    vpc_config {
      subnet_ids = data.terraform_remote_state.vpc.outputs.subnet_ids
    }
  }
  ```

**Explanation:**
Enables sharing outputs across separate projects.

---

### **41. Your Terraform plan output is too long. You want only the changes summary.**

**Solution:**

```bash
terraform plan -no-color | grep "Plan:"
```

**Output Example:**
`Plan: 1 to add, 0 to change, 0 to destroy.`

**Explanation:**
Useful in CI pipelines for clean summaries.

---

### **42. You want to enforce tagging standards across all AWS resources.**

**Solution:**
Use **Sentinel Policies** in Terraform Cloud or **OPA** with custom rules.

Example Sentinel Policy:

```hcl
import "tfplan"

main = rule {
  all tfplan.resource_changes as _, rc {
    all rc.change.after.tags as _, tag {
      tag.key matches "^env|owner|cost_center$"
    }
  }
}
```

**Explanation:**
Prevents apply unless all resources are properly tagged.

---

### **43. Your Terraform state got accidentally deleted. How do you recover?**

**Solution:**

* If using **S3 backend**: restore from versioned S3 object.
* If local: recover from `.terraform.tfstate.backup`

  ```bash
  cp terraform.tfstate.backup terraform.tfstate
  terraform plan
  ```

**Explanation:**
Terraform automatically keeps `.backup` files for safety.

---

### **44. You want to check which resource was last changed in the state.**

**Solution:**

```bash
terraform show -json | jq '.values.root_module.resources[] | {address, last_updated}'
```

**Explanation:**
Useful when debugging unexpected drifts or apply failures.

---

### **45. You want to deploy same infra in multiple regions automatically.**

**Solution:**
Use a for_each loop for providers:

```hcl
provider "aws" {
  alias  = each.key
  region = each.value
}

variable "regions" {
  default = {
    ap_south_1 = "ap-south-1"
    us_east_1  = "us-east-1"
  }
}

resource "aws_s3_bucket" "multi_region" {
  for_each = var.regions
  provider = aws.each.key
  bucket   = "konka-${each.key}-bucket"
}
```

**Explanation:**
Deploys infra in multiple regions in a single Terraform execution.

---

## ⚙️ Terraform Real-World Scenarios (Set 4 – Troubleshooting & Optimization)

---

### **46. You ran `terraform apply`, but it failed halfway. Some resources were created, others weren’t.**

**Problem:** Partial state recorded.

**Solution:**

1. Run again:

   ```bash
   terraform apply
   ```

   Terraform continues from the last successful state.
2. To clean failed resources:

   * Check in console → manually delete half-created ones if needed.
   * Re-run plan to reconcile.

**Explanation:**
Terraform is idempotent — it will align resources with the last known good state automatically.

---

### **47. Terraform plan shows changes even though no code was modified.**

**Problem:** State drift (real infra != Terraform state).

**Solution:**

```bash
terraform refresh
terraform plan
```

If still drifted — run `apply` to reconcile.

**Explanation:**
Cloud changes outside Terraform cause drift. Always manage infra *only* through Terraform.

---

### **48. Terraform apply taking too long.**

**Possible reasons:**

* Too many resources
* Remote backend latency
* Unnecessary dependencies (`depends_on` misused)

**Optimization Tips:**

* Use **`-parallelism`** flag:

  ```bash
  terraform apply -parallelism=20
  ```
* Split large stacks into modules (VPC, EKS, RDS separately)
* Use smaller backend states for faster plans.

---

### **49. Terraform shows “Provider produced inconsistent final plan”.**

**Problem:** Bug or API race between provider and Terraform.

**Fix:**

* Run again with:

  ```bash
  terraform apply -refresh-only
  ```
* If persists, upgrade provider:

  ```bash
  terraform init -upgrade
  ```

**Explanation:**
Occurs when provider APIs return unexpected or delayed values.

---

### **50. You deleted a resource manually in the console, but Terraform still thinks it exists.**

**Solution:**

1. Reconcile state:

   ```bash
   terraform refresh
   ```
2. Or remove from state:

   ```bash
   terraform state rm aws_instance.web
   terraform plan
   ```

**Explanation:**
Removes ghost entries from the state file.

---

### **51. Terraform apply fails with “Error locking state”.**

**Cause:** Another Terraform run locked the backend (e.g., crashed).

**Solution:**

```bash
terraform force-unlock <LOCK_ID>
```

**Note:** Only do this after confirming no one else is running Terraform.

---

### **52. You get “State file corrupted” error after a failed run.**

**Solution:**

* If using S3 backend with versioning:

  * Restore the last good version.
* If local:

  ```bash
  cp terraform.tfstate.backup terraform.tfstate
  terraform plan
  ```

**Explanation:**
Always enable versioning for remote backends to protect against corruption.

---

### **53. You want to debug Terraform provider API calls.**

**Solution:**
Enable debug logs:

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=terraform-debug.log
terraform apply
```

**Explanation:**
Saves all logs (provider API calls, state interactions) to a file.

---

### **54. Terraform crashes unexpectedly (segmentation fault or panic).**

**Solution:**

* Run with debug mode to get trace:

  ```bash
  TF_LOG=TRACE terraform plan
  ```
* Report to HashiCorp with crash.log.
* Often caused by outdated provider or plugin mismatch.

---

### **55. You want to simulate what Terraform will destroy without actually deleting anything.**

**Solution:**

```bash
terraform plan -destroy
```

**Explanation:**
Shows a destruction plan — helps you review what would be deleted.

---

### **56. You accidentally removed `.terraform` folder.**

**Solution:**
Reinitialize your workspace:

```bash
terraform init
```

State file (`terraform.tfstate`) remains intact, so no resources are lost.

---

### **57. You’re using Terraform Cloud but plan keeps failing with “Permission denied”.**

**Possible causes:**

* API token missing
* Wrong workspace variable setup

**Fix:**

* Verify environment variable:

  ```bash
  export TF_CLOUD_TOKEN=<your_token>
  ```
* Ensure VCS repo linked to workspace and has proper access.

---

### **58. You’re getting error: “Error: Provider configuration not present”.**

**Problem:**
Provider block is missing or incorrectly scoped in modules.

**Fix:**
In root module:

```hcl
provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "../modules/vpc"
  providers = {
    aws = aws
  }
}
```

**Explanation:**
Modules need an explicit provider mapping if not inherited automatically.

---

### **59. You want to run a plan to only refresh the state without changing infrastructure.**

**Solution:**

```bash
terraform plan -refresh-only
```

**Explanation:**
Good for auditing current infra and detecting drift without modification.

---

### **60. You want to avoid storing sensitive variables (like passwords) in `.tfvars`.**

**Best Practices:**

* Use `sensitive = true` in variable definitions:

  ```hcl
  variable "db_password" {
    type      = string
    sensitive = true
  }
  ```
* Fetch from AWS Secrets Manager or SSM:

  ```hcl
  data "aws_ssm_parameter" "db_pwd" {
    name            = "/prod/db/password"
    with_decryption = true
  }
  ```
* Or use environment variable:

  ```bash
  export TF_VAR_db_password="SuperSecret123!"
  ```

**Explanation:**
Keeps secrets secure and hidden from logs, tfstate, and Git.

---

## ✅ Summary — After Set 4, You Now Know:

| Category        | You Can Handle                              |
| --------------- | ------------------------------------------- |
| 🌐 Infra Mgmt   | Multi-env setups, Terragrunt, Remote states |
| 🔁 Lifecycle    | Imports, Drift, Dependency handling         |
| 🧩 Modules      | Versioning, reuse, inter-module outputs     |
| ⚙️ Commands     | All core, state, and advanced CLI flags     |
| 🚨 Errors       | Locking, Corruption, Drift, Apply failures  |
| 🧠 Optimization | Plan speed, parallelism, state hygiene      |

---

Here’s the **next extended list of Terraform scenario-based and conceptual questions (Set-4)** — all are realistic and help you master interviews and practical use cases 👇

---

## **Set-4: Terraform Advanced & Real-World Scenarios**

### **State Management & Backend**

1. What is Terraform state, and why is it important?
2. What are the problems if multiple users modify the same state file simultaneously?
3. How do you enable remote state storage in S3?
4. Why do we use DynamoDB with S3 backend?
5. What is the difference between `local` and `remote` backends?
6. How can you lock the Terraform state file to prevent corruption?
7. How do you handle state drift in Terraform?
8. If your state file gets corrupted, how can you recover it?

---

### **Workspaces & Environments**

9. What are Terraform workspaces, and when should you use them?
10. Difference between Terraform workspaces and separate state files?
11. How do you handle dev/stage/prod environments in Terraform?
12. Can you share variables between workspaces?

---

### **Modules & Reusability**

13. What is a Terraform module?
14. Difference between root and child modules?
15. How do you version control Terraform modules?
16. How do you call a module stored in a GitHub repository?
17. What are the benefits of using modules in a large organization?
18. How do you pass outputs from one module to another?
19. How can you create reusable modules for multi-environment deployments?

---

### **Provisioners & Dependencies**

20. What is a Terraform provisioner?
21. What is the difference between `local-exec` and `remote-exec`?
22. When should provisioners be avoided?
23. How do you handle resource dependencies in Terraform?
24. What is `depends_on`, and when do you use it?
25. How do you handle execution order in Terraform?

---

### **Lifecycle & Meta-Arguments**

26. What is the purpose of the `lifecycle` block?
27. Explain `create_before_destroy` and its use case.
28. What is `ignore_changes` and when to use it?
29. How can you prevent accidental deletion of critical resources?

---

### **Real-world Scenarios**

30. You modified a resource in the AWS Console directly. How do you bring it back into Terraform control?
31. How do you handle secrets like passwords or API keys in Terraform?
32. How can you roll back to a previous infrastructure version?
33. How do you manage Terraform configurations across multiple regions?
34. How would you import existing resources into Terraform without destroying them?
35. What would you do if `terraform apply` fails halfway?

---

### **Team & CI/CD Integration**

36. How do you integrate Terraform with Jenkins or GitHub Actions?
37. How do you manage Terraform state in a team setup?
38. How do you handle Terraform code reviews and approvals in pipelines?
39. What security best practices do you follow in Terraform projects?
40. How do you perform automated validation before `terraform apply`?

---
Perfect 👌 Here’s **Set-5: Terraform Cloud, Workspaces & Enterprise-Level Concepts** — these are **commonly asked in senior-level DevOps interviews** and reflect **real-world usage in large teams**.

---

## **Set-5: Terraform Cloud, Workspaces & Enterprise Concepts**

### **Terraform Cloud & Enterprise**

1. What is Terraform Cloud, and how is it different from Terraform OSS?
2. What is the benefit of using Terraform Cloud in a team environment?
3. What are the main features of Terraform Cloud? (e.g., remote execution, version control integration, private module registry)
4. What is a Terraform Organization in Terraform Cloud?
5. What are Workspaces in Terraform Cloud? How do they differ from CLI workspaces?
6. How do you connect Terraform Cloud to a GitHub repository?
7. How does Terraform Cloud handle state storage and locking?
8. What is the difference between Terraform Cloud and Terraform Enterprise?
9. How does Terraform Cloud provide role-based access control (RBAC)?
10. What is the private module registry, and how do teams benefit from it?

---

### **Sentinel Policy as Code**

11. What is Sentinel in Terraform Enterprise?
12. How does Sentinel help in enforcing organizational policies?
13. Can you give an example of a Sentinel policy use case (like enforcing tags or preventing large EC2 instances)?
14. What are the different enforcement levels in Sentinel (`advisory`, `soft mandatory`, `hard mandatory`)?
15. How can you integrate Sentinel policies in your Terraform pipeline?

---

### **Cost Estimation & Governance**

16. How does Terraform Cloud perform cost estimation?
17. How can you set budget limits using Sentinel or custom scripts?
18. How can you track infrastructure changes over time for audit purposes?
19. What are some governance and compliance best practices in Terraform Cloud?
20. How do you ensure infrastructure deployments are approved before applying changes?

---

### **Drift Detection & Automation**

21. What is drift detection in Terraform Cloud?
22. How does drift detection help maintain consistent infrastructure?
23. How can you automate drift detection using CI/CD?
24. What’s the difference between drift detection and terraform refresh?
25. How can you automatically fix or alert when drift is detected?

---

### **Team Collaboration & Security**

26. How do you securely share Terraform variables (like credentials) in a team?
27. What are Terraform Cloud variable sets?
28. How do you manage multiple environments (dev/stage/prod) securely in Terraform Cloud?
29. How do you restrict who can apply changes in Terraform Cloud?
30. What’s the difference between “run triggers” and “manual apply” in Terraform Cloud?

---

### **Performance & Scaling**

31. How do you handle very large Terraform configurations?
32. How do you break a monolithic Terraform project into manageable modules?
33. What are remote execution agents in Terraform Cloud?
34. What’s the best way to manage dependencies across multiple workspaces?
35. How do you handle multi-cloud or hybrid infrastructure using Terraform Cloud?

---

🔥 Awesome, Konka!
Here’s your **Set-6: Terraform Troubleshooting & Best Practices** — these are the kind of **real-time scenario questions** interviewers use to check your **hands-on knowledge and problem-solving ability.**

---

## **Set-6: Terraform Troubleshooting & Best Practices**

### 🧩 **1. Troubleshooting & Debugging**

1. How do you debug when `terraform apply` fails?
2. What is the purpose of the `TF_LOG` environment variable, and what are its log levels?
3. How do you inspect the exact API calls Terraform is making to a provider?
4. What does the error “Error locking state” mean and how do you fix it?
5. How do you recover a corrupted or deleted Terraform state file?
6. What steps do you take if your remote backend (e.g., S3 + DynamoDB) is unreachable?
7. How do you handle a resource that’s stuck in “provisioning” state?
8. When would you use `terraform refresh` or `terraform state rm` to fix a drift?
9. How do you handle provider version conflicts or plugin errors?
10. How do you roll back infrastructure changes after a failed deployment?

---

### ⚙️ **2. State Management Issues**

11. What happens if two people run `terraform apply` at the same time?
12. How do you manually lock and unlock Terraform state in S3 backend?
13. How can you migrate a local state file to a remote backend safely?
14. How do you handle a mismatch between actual resources and state file?
15. What’s the difference between `terraform refresh` and drift detection tools?

---

### 🧱 **3. Performance Optimization**

16. How do you speed up Terraform plan/apply for large environments?
17. What’s the difference between splitting configurations into multiple workspaces vs multiple states?
18. How do you modularize Terraform for faster and safer deployments?
19. What’s the advantage of using `for_each` instead of `count`?
20. How do you handle hundreds of resources without performance impact?

---

### 🧠 **4. Design & Architecture Best Practices**

21. What is the best folder structure for managing multiple environments (dev, stage, prod)?
22. How do you handle secrets in Terraform (AWS keys, passwords, etc.)?
23. Why should you never store state files in source control?
24. How do you design reusable and composable Terraform modules?
25. How do you ensure consistency across teams working on the same infrastructure?

---

### 🛡️ **5. Security & Compliance**

26. How do you protect sensitive outputs in Terraform?
27. What is the purpose of `sensitive = true` in variable definitions?
28. How do you enforce tagging and naming conventions using Terraform?
29. How can Sentinel or OPA (Open Policy Agent) be used for security in Terraform?
30. How do you secure backend credentials in Terraform Cloud or S3 backends?

---

### 🚨 **6. Disaster Recovery & Backup**

31. What happens if you lose your Terraform state file?
32. How do you back up Terraform state files automatically?
33. What’s your DR plan if an accidental `terraform destroy` is executed?
34. How do you ensure rollback capability in Terraform?
35. How can version control (Git) help with disaster recovery for IaC?

---

### 🧭 **7. Real-World Scenarios**

36. Your team applied Terraform manually in prod and now CI/CD pipeline plans show large changes — what do you do?
37. How do you deploy different module versions for different environments?
38. Your Terraform apply fails in one region but succeeds in another — how do you debug that?
39. How do you ensure blue/green or rolling deployments using Terraform?
40. How would you design Terraform for a microservices-based architecture with many teams?

---

Would you like me to make **Set-7: Terraform CI/CD Integration & Automation Scenarios** next (covering how Terraform fits into GitHub Actions, Jenkins, and approval workflows)?
---
🔥 Perfect, Konka!
Here’s your **Set-7: Terraform CI/CD Integration & Automation Scenarios** — focused on **real-time DevOps workflows** with Terraform, GitHub Actions, Jenkins, and approval gates.
These questions are super valuable because most interviewers test **automation mindset** and **team collaboration practices** here.

---

## **Set-7: Terraform CI/CD Integration & Automation**

### ⚙️ **1. CI/CD Pipeline Basics with Terraform**

1. How do you integrate Terraform into a CI/CD pipeline (e.g., Jenkins or GitHub Actions)?
2. What are the typical stages of a Terraform pipeline (init → plan → approval → apply)?
3. Why is it recommended to separate the `plan` and `apply` stages in CI/CD?
4. How do you ensure that only approved plans are applied in production?
5. How do you securely handle AWS credentials or backend access in CI/CD?

---

### 🧰 **2. GitHub Actions Integration**

6. How do you structure a GitHub Actions workflow for Terraform?
7. What’s the purpose of using `hashicorp/setup-terraform` action in pipelines?
8. How can you automatically run `terraform fmt` and `terraform validate` on every pull request?
9. How do you store and use environment-specific variables or secrets in GitHub Actions?
10. How can you configure GitHub Actions to push the Terraform state to an S3 backend or Terraform Cloud?

---

### 🏗️ **3. Jenkins Integration**

11. How do you implement Terraform automation in Jenkins?
12. How do you manage state locking and concurrency when multiple jobs run Terraform?
13. How can Jenkins pipelines handle approvals before `terraform apply`?
14. How do you handle rollback if Jenkins pipeline fails after partial apply?
15. What are the benefits of using Jenkins shared libraries for Terraform automation?

---

### 🧩 **4. Environment & Workspace Automation**

16. How do you use Terraform workspaces in CI/CD for dev, stage, and prod?
17. How do you pass workspace-specific variables automatically in pipelines?
18. What’s the difference between using workspaces vs. separate state files per environment?
19. How do you ensure environment isolation in a shared Terraform Cloud organization?
20. How do you automatically create a new workspace for a feature branch in GitHub Actions?

---

### 🧠 **5. Approval & Change Control**

21. How do you integrate manual approvals in a Terraform deployment pipeline?
22. What’s the purpose of storing Terraform plan outputs as artifacts (e.g., `plan.out`)?
23. How can you generate and review plan files before merging pull requests?
24. How do you enforce “no direct apply” rules on production environments?
25. How can Terraform Cloud’s remote runs improve governance in CI/CD pipelines?

---

### 🧱 **6. Module & Version Management**

26. How do you manage Terraform module versions across pipelines?
27. How do you validate module syntax automatically before merging code?
28. What’s the best way to publish internal modules and reuse them via Terraform Registry?
29. How do you test new versions of a module safely before promoting to prod?
30. How do you handle dependency changes between multiple modules in CI/CD?

---

### 🔒 **7. Security & Compliance in Automation**

31. How do you prevent storing sensitive data like keys or passwords in pipelines?
32. How do you integrate security scanning tools (like tfsec or Checkov) into Terraform pipelines?
33. How can you automate compliance checks using Sentinel or OPA in CI/CD?
34. How do you ensure pipelines automatically fail for unapproved regions or instance types?
35. How do you rotate secrets or credentials used by Terraform pipelines?

---

### 🚀 **8. Advanced Automation Scenarios**

36. How do you trigger Terraform plans automatically when infrastructure code changes?
37. How can you use Git tags or branches to control which environment Terraform deploys to?
38. How do you integrate Terraform automation into a multi-repo or mono-repo setup?
39. How can you parallelize Terraform deployments across multiple regions?
40. How do you combine Terraform with Helm or Ansible in a single CI/CD workflow?

---

Would you like me to create **Set-8: Terraform Real-Time Project Scenarios** next — where I’ll cover **multi-tier infra design, DR setups, blue/green deployments, and hybrid cloud projects** (like AWS + GCP + on-prem)?

---
Perfect, Konka! 🔥
Here’s **Set-8: Terraform Real-Time Project Scenarios** — these are **end-to-end, production-style questions** that interviewers often ask for senior DevOps roles.
They combine **design thinking, Terraform skills, CI/CD, and troubleshooting**.

---

## **Set-8: Terraform Real-Time Project Scenarios**

### 🏗️ **1. Multi-Tier Infrastructure**

1. How would you design a 3-tier web application (frontend, backend, database) using Terraform?
2. How do you separate environments (dev, stage, prod) while reusing modules?
3. How do you manage shared resources like VPC, subnets, and security groups?
4. How do you handle dependency between modules (e.g., VPC → EKS → RDS)?
5. How would you handle DNS management (Route 53) with Terraform for multi-tier apps?

---

### 🌐 **2. High Availability & Disaster Recovery**

6. How do you deploy highly available infrastructure across multiple AZs using Terraform?
7. How do you design DR (Disaster Recovery) using Terraform for AWS?
8. How would you replicate infrastructure to a secondary region?
9. How do you handle Terraform state backup and restore for DR purposes?
10. How would you implement blue/green or canary deployments for a web application?

---

### ☁️ **3. Hybrid & Multi-Cloud Projects**

11. How do you design infrastructure spanning AWS and GCP using Terraform?
12. How do you manage multiple providers in a single Terraform project?
13. How do you handle secrets and credentials for different clouds?
14. How do you ensure consistent tagging and naming across clouds?
15. How would you migrate existing on-prem resources into Terraform-managed infrastructure?

---

### 🔄 **4. CI/CD Integration in Projects**

16. How would you implement end-to-end Terraform automation with GitHub Actions/Jenkins for this project?
17. How do you handle approval workflows for staging vs production environments?
18. How do you integrate Terraform plan outputs into PR reviews for multi-tier infra?
19. How would you implement automated drift detection and remediation?
20. How do you manage module updates and versioning in CI/CD pipelines?

---

### 🛡️ **5. Security & Compliance**

21. How do you enforce tagging, IAM policies, and security groups using Terraform?
22. How would you prevent developers from creating public-facing S3 buckets accidentally?
23. How can you integrate Terraform with Sentinel/OPA to enforce compliance policies?
24. How do you manage sensitive data like passwords, API keys, or certificates securely?
25. How do you monitor and audit infrastructure changes via Terraform?

---

### ⚡ **6. Optimization & Cost Management**

26. How do you design infrastructure to optimize cost using Terraform?
27. How would you manage multiple environments without creating duplicate resources?
28. How can Terraform Cloud’s cost estimation feature help in your project?
29. How do you reduce plan/apply time for large projects?
30. How would you implement tagging strategies for cost allocation and reporting?

---

### 🧩 **7. Real-Time Troubleshooting Scenarios**

31. Terraform fails in the middle of creating an EKS cluster — what steps do you take?
32. Terraform plan shows all resources to be destroyed even though nothing changed — how do you debug?
33. How would you recover from a corrupted or lost Terraform state during production deployment?
34. How do you handle a resource that was manually modified outside Terraform?
35. How do you fix dependency cycles or misconfigured modules in a large project?

---

This set basically covers **everything you’d encounter in a real Terraform project** — design, automation, multi-cloud, security, cost, and troubleshooting.

If you want, I can now **combine all Sets 1–8 into a single ultimate Terraform interview roadmap** with **all scenarios, commands, best practices, and CI/CD workflows** — so you’ll have **one master sheet** to study before interviews.

