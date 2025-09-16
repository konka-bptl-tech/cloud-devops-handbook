## **AWS IAM (Identity and Access Management)**

IAM is a service that helps you **securely manage access** to AWS services and resources.

---

### **1. IAM Users**

* Represents a **person or application** that interacts with AWS.
* Has **credentials** (username/password, access keys).
* Example:

  * **Developer** who needs access to EC2.
  * **Application** that needs access to S3.

---

### **2. IAM Groups**

* A **collection of users** that share the same permissions.
* You attach **policies to groups**, not directly to every user.
* Example:

  * `Developers` group with EC2 and S3 read permissions.
  * `Admins` group with full access.

---

### **3. IAM Roles**

* **Temporary access** with **permissions**.
* **No long-term credentials** (uses STS - Security Token Service).
* Commonly used for:

  * **EC2 instance role** → EC2 can access S3 without hardcoding credentials.
  * **Cross-account access**.
  * **Service roles** for AWS services.

---

### **4. IAM Policies**

Policies define **what actions are allowed or denied**.

#### **Types of Policies**

✅ **AWS Managed Policies**

* Created and maintained by AWS.
* Example: `AmazonS3FullAccess`, `AmazonEC2ReadOnlyAccess`.

✅ **Customer Managed Policies**

* Created by you for custom permissions.
* Example:

  ```json
  {
    "Effect": "Allow",
    "Action": ["s3:GetObject", "s3:PutObject"],
    "Resource": "arn:aws:s3:::mybucket/*"
  }
  ```

✅ **Inline Policies**

* Attached **directly to a single user, group, or role**.
* Not reusable.
* Example:

  * User `John` has a specific inline policy to manage only `S3/mybucket`.

---

### **5. Permission Boundaries**

* A **limit** on the maximum permissions an IAM user or role can have.
* Even if policies give more permissions, **boundary restricts them**.
* Example:

  * **Boundary Policy:**

    ```json
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
    ```
  * If you attach this boundary to a user, they can only work with **S3**, even if their inline policy says `ec2:*`.

✅ **Real scenario:**

* Company policy:

  * Developers should never get more than S3 access.
  * Attach **permission boundary** allowing only `s3:*`.
  * Even if an admin accidentally gives EC2 full access in their policy, the boundary blocks it.
---

### **What is a Trust Policy?**

* A **trust policy** is a JSON policy document that **defines who can assume a role**.
* It is **attached to an IAM role**, not a user or group.
* It specifies the **trusted entities** (users, roles, services, or accounts) allowed to **assume the role** using **STS\:AssumeRole**.

---

### **Why is it needed?**

* Roles do not have long-term credentials.
* For someone (or something) to use a role, AWS must know **who is allowed to assume it**.
* This is controlled by the **trust policy**.

---

### **Example 1: EC2 Role Trust Policy**

When you create an IAM role for EC2 to access S3, the **trust policy** looks like this:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

**Meaning:**

* EC2 service (`ec2.amazonaws.com`) is allowed to assume this role.

---

### **Example 2: Cross-Account Role Trust Policy**

Allow an AWS account (`123456789012`) to assume this role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

**Meaning:**

* Any user in account **123456789012** can assume this role (if they have `sts:AssumeRole` permission on their side).

---

✅ **Key Points:**

* **Permission policy** = What actions the role can do.
* **Trust policy** = Who is allowed to assume the role.

---
Here’s a **clear comparison**:

---

### ✅ **Identity-Based Policies**

* **Attached To:** IAM **users, groups, or roles**.
* **Purpose:** Defines **what actions an identity can perform on which resources**.
* **Example:**
  A policy attached to a user allowing them to read S3 objects.

  ```json
  {
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::mybucket/*"
  }
  ```
* **Use Case:**

  * Assign permissions to **people or applications**.

---

### ✅ **Resource-Based Policies**

* **Attached To:** The **resource itself** (like an S3 bucket, SNS topic, SQS queue, Secrets Manager secret).
* **Purpose:** Defines **who (Principal) can access the resource and what they can do**.
* **Example (S3 bucket policy):**

  ```json
  {
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::123456789012:user/Alice"
    },
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::mybucket/*"
  }
  ```
* **Use Case:**

  * Give **cross-account access**.
  * Allow **public access**.

---

### ✅ **Key Differences in Table**

| Feature                  | Identity-Based Policy              | Resource-Based Policy                 |
| ------------------------ | ---------------------------------- | ------------------------------------- |
| **Attached To**          | IAM user, group, or role           | AWS resource (S3, SNS, SQS, etc.)     |
| **Specifies**            | What the identity can do           | Who can access the resource & actions |
| **Principal Field**      | Not used (attached to identity)    | Mandatory (defines who is allowed)    |
| **Cross-Account Access** | Needs role assumption              | Easier with resource policy           |
| **Common Examples**      | IAM policies (AWS Managed, custom) | S3 bucket policy, SNS topic policy    |

---

✅ **Quick Summary:**

* **Identity-Based →** *What can this user/role do?*
* **Resource-Based →** *Who can access this resource?*

---