### ✅ What is a Circular Dependency in Terraform?

A **circular dependency** happens when two or more resources depend on each other in a way that Terraform cannot determine which one to create first. This creates a **dependency loop**.

---

### ✅ **Simple Example**

```hcl
provider "aws" {
  region = data.aws_region.current.region
}

data "aws_region" "current" {
  name = var.aws_region
}
```

**What’s happening here?**

* `provider "aws"` needs `data.aws_region.current.region`
* `data.aws_region.current` needs the provider to be initialized
* **Terraform gets confused → “Cycle: data.aws\_region.current, provider”**

---

### ✅ **Why is this a Cycle?**

* Provider initialization happens **before** data sources are read.
* But here, the provider depends on a data source → **impossible for Terraform**.

---

### ✅ **How to Fix It**

Just remove the dependency. Instead of fetching region dynamically, **use a variable**:

✅ Correct:

```hcl
variable "aws_region" {
  default = "ap-south-1"
}

provider "aws" {
  region = var.aws_region
}
```

---

### ✅ **Real-World Example for Interview**

Imagine:

* You have an **S3 bucket** for state
* You want to use that **bucket name** from Terraform output in the backend configuration

**Wrong way (Cycle)**:

```hcl
backend "s3" {
  bucket = aws_s3_bucket.terraform_state.bucket
}
```

Here:

* **Backend needs S3 bucket** → to create state
* **S3 bucket needs backend** → to store state
* **Cycle!**

✅ Correct approach:

* **Manually create** the S3 bucket first (or use separate bootstrap script)
* Then configure backend with the static bucket name

---

### ✅ **How to Explain in Interview in Simple Words**

> "A circular dependency in Terraform happens when two resources depend on each other, so Terraform cannot decide which to create first. For example, if the AWS provider tries to get the region from a data source, but the data source needs the provider initialized first, it creates a cycle. The solution is to break the loop by using variables or external configuration."

---

### ✅ **1. EKS Cluster + IAM Role**

**Scenario:**

* You create an **EKS cluster** that needs an **IAM role** for the control plane.
* The **IAM role** policy references the **EKS cluster ARN**.

**Code (Wrong - Creates Cycle):**

```hcl
resource "aws_iam_role" "eks_role" {
  name = "eks-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume.json
}

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Adding a policy that references the cluster ARN
  depends_on = [aws_iam_role.eks_role]
}

resource "aws_iam_role_policy" "eks_policy" {
  name = "eks-policy"
  role = aws_iam_role.eks_role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect"   : "Allow",
      "Action"   : "eks:*",
      "Resource" : aws_eks_cluster.example.arn
    }]
  })
}
```

**Why Cycle?**

* `aws_eks_cluster` needs `aws_iam_role`
* `aws_iam_role_policy` needs `aws_eks_cluster.arn`

✅ **Fix:** Use `*` or partial ARNs, or create policy **without referencing cluster ARN**.

---

### ✅ **2. VPC Peering Connection**

**Scenario:**

* VPC A needs a route to VPC B.
* VPC B needs a route to VPC A.
* Both routes depend on **VPC Peering ID**.

**Wrong Way (Cycle):**

```hcl
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.a.id
  peer_vpc_id   = aws_vpc.b.id
  auto_accept   = true
}

resource "aws_route" "route_a" {
  route_table_id         = aws_route_table.a.id
  destination_cidr_block = aws_vpc.b.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "route_b" {
  route_table_id         = aws_route_table.b.id
  destination_cidr_block = aws_vpc.a.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
```

**Why Cycle?**

* `aws_vpc_peering_connection` depends on VPC A & B.
* Both routes depend on the peering.
* If you add extra dependencies like security groups referencing routes → **Cycle**.

✅ **Fix:** Use `depends_on` wisely or split into multiple applies.

---

### ✅ **3. Auto Scaling Group + Load Balancer**

**Scenario:**

* ASG references Target Group ARN.
* Target Group references an instance from ASG for health checks.

**Wrong Way:**

```hcl
resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    target = aws_instance.asg_instance.private_ip
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "app-asg"
  launch_configuration      = aws_launch_configuration.app.id
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = [aws_lb_target_group.app.arn]
}
```

**Why Cycle?**

* ASG needs Target Group.
* Target Group health check references ASG instances → **Cycle**.

✅ **Fix:** Remove explicit dependency on ASG instance IP for health check (use defaults).

---

### ✅ **How to Explain in Interview in One Line**

> “Circular dependency usually happens when resource A depends on resource B, and B depends on A. For example, EKS cluster and IAM role policies referencing each other, VPC peering routes, or ASG and target group health checks. The fix is to decouple resources using variables, multiple applies, or removing hard references.”

---