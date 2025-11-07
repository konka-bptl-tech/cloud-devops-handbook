## 🔹 Scenario: Fixing “Unsupported Attribute” Error When Using Terraform Modules in Azure

### 🧩 Background

You are creating an Azure Resource Group and a Storage Account using **Terraform modules**.
Each resource type has its own module:

* `modules/rg` → for creating a Resource Group
* `modules/storageaccount` → for creating a Storage Account

In your root `main.tf`, you call these modules like this:

```hcl
module "rg" {
  source       = "../modules/rg"
  project_name = var.common_vars["project_name"]
  environment  = var.common_vars["environment"]
  location     = var.rg["location"]
  tags         = var.common_vars["common_tags"]
}

module "storage_account" {
  source                   = "../modules/storageaccount"
  environment              = var.common_vars["environment"]
  project_name             = var.common_vars["project_name"]
  rg_name                  = module.rg.name
  rg_location              = module.rg.location
  account_tier             = var.storage_account["account_tier"]
  account_replication_type = var.storage_account["account_replication_type"]
  tags                     = var.common_vars["common_tags"]
}
```

When you run `terraform plan`, you get this error:

```
Error: Unsupported attribute
│ module.rg is a object
│ This object does not have an attribute named "location".
```

---

### ⚠️ Problem

The **`rg` module** does not expose a `location` output.
Terraform modules are isolated — they only share information with other modules through `output` blocks.
Since you’re referencing `module.rg.location`, Terraform expects an **output named `location`** inside the RG module, which doesn’t exist yet.

---

### ✅ Solution

Add an **output block** for `location` in your `../modules/rg/outputs.tf` file.

**Before:**

```hcl
output "id" {
  value = azurerm_resource_group.example.id
}
output "name" {
  value = azurerm_resource_group.example.name
}
```

**After (fixed):**

```hcl
output "id" {
  value = azurerm_resource_group.example.id
}

output "name" {
  value = azurerm_resource_group.example.name
}

output "location" {
  value = azurerm_resource_group.example.location
}
```

Now you can safely reference:

```hcl
rg_name     = module.rg.name
rg_location = module.rg.location
```

---

### ✅ Why Your Tutor’s Direct Code Worked

In your tutor’s example, both resources (`azurerm_resource_group` and `azurerm_storage_account`) were **defined in the same root module**, so Terraform automatically knew the dependency and could directly reference:

```hcl
location = azurerm_resource_group.example.location
```

When you use **modules**, Terraform treats them as separate boxes — it can only access values that are **explicitly output** from one module to another.

---

### 🧠 Key Takeaways

| Concept                                       | Explanation                                                            |
| --------------------------------------------- | ---------------------------------------------------------------------- |
| Modules are isolated                          | Terraform cannot access resources inside a module directly.            |
| Outputs bridge modules                        | You must expose values through `output` blocks.                        |
| Direct references work only in the same scope | That’s why your tutor’s code didn’t fail.                              |
| Fix                                           | Add `output "location"` (and any other needed outputs) in your module. |

---

### 📁 Final Folder Structure Example

```
terraform/
├── main.tf
├── variables.tf
├── modules/
│   ├── rg/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── storageaccount/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```

---