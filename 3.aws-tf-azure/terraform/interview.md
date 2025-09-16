## 🔥 Terraform Tricky Questions & Cheat Sheet

### 🟢 State & Backend

**Q1.** What happens if two team members run `terraform apply` at the same time on the same state file?
👉 State conflict → last write wins → resources drift/corruption possible. Use remote backend with **state locking** (e.g., S3 + DynamoDB lock).

**Q2.** You accidentally deleted the `.terraform` folder. What impact will this have and how do you recover?
👉 Only providers & module cache lost → state file is intact → just run `terraform init` again.

**Q3.** If the state file is corrupted, how can you recover resources already provisioned in AWS?
👉 Use `terraform refresh` or **import** resources back (`terraform import`) → or restore state from **S3 versioning / backup**.

**Q4.** Can you manually edit the Terraform state file? In what situations?
👉 Yes, but risky. Do it only to fix drift, rename resources, or unblock state issues (last resort).

**Q5.** Your state is in S3 with DynamoDB locking. One apply got stuck. How do you unlock the state safely?
👉 Use `terraform force-unlock <LOCK_ID>` after checking no other operation is active.

---

### 🟢 Modules & Reusability

**Q6.** If two modules define the same resource name but are used in the same root module?
👉 No conflict because resources are namespaced per module.

**Q7.** How do you pass outputs from one module to another without exposing them?
👉 Use **module outputs → root module variables → pass to next module**. Don’t store secrets in plain outputs; use Vault/SSM.

**Q8.** Module with 20 variables – how handle optional vars without breaking old code?
👉 Use `default` values in variables, or `null` + conditional expressions.

**Q9.** What happens if you upgrade a module and resource names inside it change?
👉 Terraform sees them as **new resources → destroys old → creates new**. Mitigation: use `lifecycle { prevent_destroy }` or `terraform state mv`.

---

### 🟢 Variables & Expressions

**Q10.** Difference between `count` and `for_each`?
👉 `count` = index-based (good for identical resources).
👉 `for_each` = map/set-based (good for named resources).

**Q11.** Can `count` and `for_each` be used together?
👉 No, only one per resource.

**Q12.** How do you create dynamic nested blocks (like SG rules) with `for_each`?
👉 Use `dynamic` blocks with `for_each`.

**Q13.** If a variable is not provided, how does Terraform resolve it?
👉 Order: **default → tfvars → CLI `-var` → ENV var → TF\_VAR\_ prefix → interactive prompt**.

**Q14.** How to handle secrets in variables without exposing in state?
👉 Use SSM Parameter Store / Secrets Manager / Vault. Avoid `sensitive=false` outputs.

---

### 🟢 Lifecycle & Drift

**Q15.** What does `terraform refresh` do?
👉 Syncs state with real infra (but doesn’t change infra).

**Q16.** If someone changes resource in AWS console, how does Terraform detect?
👉 At `plan`/`apply` time → shows drift → recreates/updates resource to match config.

**Q17.** Purpose of `prevent_destroy`? Can it still be deleted?
👉 Blocks destroy by Terraform. Can bypass with `-target`, `-replace`, or manually editing state.

**Q18.** Ignore drift for specific attributes?
👉 Use `lifecycle { ignore_changes = [tags, …] }`.

**Q19.** Import a resource, then remove from config?
👉 Next apply will **destroy** it (because it’s managed in state but not in config).

---

### 🟢 Workspaces & Environments

**Q20.** Difference between Workspaces vs separate state files?
👉 Workspaces = multiple state files in one backend (not recommended for prod).
👉 Separate state files = better isolation per env.

**Q21.** Can you share variables between workspaces?
👉 No, each workspace has its own state. You must use external sources (like SSM, remote data).

**Q22.** Migrate from local to remote backend without losing resources?
👉 Run `terraform init -migrate-state`.

---

### 🟢 Provisioners & Execution

**Q23.** Why are provisioners last resort?
👉 They break idempotency, make infra brittle. Use user\_data or config mgmt instead.

**Q24.** What happens if a `local-exec` fails?
👉 Terraform fails the resource creation.

**Q25.** How to rerun only failed provisioners?
👉 `taint` the resource → reapply, or use `null_resource` with `triggers`.

---

### 🟢 Real-World Scenarios

**Q26.** Ran `terraform destroy` in prod by mistake. How recover?
👉 Restore infra from **state backup** or reapply Git configs + `terraform import`.

**Q27.** Thousands of resources – apply only subset?
👉 Use `-target` flag or `-refresh-only`.

**Q28.** Manage dependencies across modules without `depends_on`?
👉 Use **outputs/inputs** (module A outputs → module B input).

**Q29.** Multi-region deployments with shared VPC?
👉 Separate state files per region, use shared VPC module, or data sources across backends.

**Q30.** Large codebase with multiple teams?
👉 Use **modules + remote state** + GitOps structure (per team/module repo).

---



Here are some of the ones that stumped me:
1) What is the difference between 𝐭𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐢𝐦𝐩𝐨𝐫𝐭 and 𝐭𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐭𝐚𝐢𝐧𝐭?
2) How do you manage secrets in Terraform without hardcoding them?
3) What’s the difference between 𝐜𝐨𝐮𝐧𝐭 and 𝐟𝐨𝐫_𝐞𝐚𝐜𝐡? Give a real-world use case.
4) How do you handle drift detection in Terraform?
5) What is a Terraform remote backend, and why is it important?
6) How do you manage multiple environments (dev, staging, prod) in Terraform?
7) Difference between 𝐥𝐨𝐜𝐚𝐥-𝐞𝐱𝐞𝐜 and 𝐫𝐞𝐦𝐨𝐭𝐞-𝐞𝐱𝐞𝐜 provisioners.
8) How do you safely roll back infrastructure changes after a failed deployment?
9) Explain 𝐭𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐫𝐞𝐟𝐫𝐞𝐬𝐡 vs 𝐭𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐩𝐥𝐚𝐧.
10) How do you write reusable Terraform modules?

😓 I failed that day.

Truth is…
Most DevOps engineers underestimate 𝐓𝐞𝐫𝐫𝐚𝐟𝐨𝐫𝐦 𝐟𝐮𝐧𝐝𝐚𝐦𝐞𝐧𝐭𝐚𝐥𝐬.
They focus on writing simple .𝐭𝐟 files but struggle with 𝐬𝐭𝐚𝐭𝐞 𝐦𝐚𝐧𝐚𝐠𝐞𝐦𝐞𝐧𝐭, 𝐦𝐨𝐝𝐮𝐥𝐞𝐬, 𝐚𝐧𝐝 𝐫𝐞𝐚𝐥-𝐰𝐨𝐫𝐥𝐝 𝐜𝐨𝐦𝐩𝐥𝐞𝐱𝐢𝐭𝐢𝐞𝐬.

And interviewers know it.
That’s why companies reject candidates for weak Terraform skills, even if they are Kubernetes or AWS experts.

My advice: Don’t just learn the basics.
Master the internals of Terraform — state files, workspaces, modules, and best practices. These are the silent deal-breakers in high-paying DevOps interviews.