# 🌐 What is **NAT (Network Address Translation)?**

> **NAT** is a networking technique where **IP addresses are translated** from one form to another (usually private ↔ public), allowing multiple devices to share a single public IP or access external networks securely.

---

# 🔁 Types of NAT

| Type     | Stands For      | Direction                       | Purpose                                               |
| -------- | --------------- | ------------------------------- | ----------------------------------------------------- |
| **SNAT** | Source NAT      | **Outbound** (Private → Public) | When **internal systems** connect **to the internet** |
| **DNAT** | Destination NAT | **Inbound** (Public → Private)  | When **external users** access **internal services**  |

---

## 🧠 Simple Definitions:

### 🔹 SNAT (Source NAT):

> Changes the **source IP** of a request when going **out** of the private network.

### 🔹 DNAT (Destination NAT):

> Changes the **destination IP** of a request when coming **in** to the private network.

---

## ✅ AWS NAT Gateway (NAT GW)

> A **managed AWS service** used to enable **instances in a private subnet** to access the **internet**, without exposing them to incoming traffic.

* It performs **SNAT only** (for outbound)
* **Does not support DNAT** (no inbound allowed)

---

## 🏗️ How NAT Translation Works (AWS VPC)

### Scenario:

* You have a **private subnet** with an EC2 instance
* You want it to **access the internet** (e.g., to update packages)

🧱 Setup:

* EC2 in **Private Subnet**
* NAT Gateway in **Public Subnet**
* Route Table: Private subnet → NAT Gateway
* Internet Gateway (IGW) for outbound NAT traffic

---

## 🔁 SNAT Flow (AWS NAT GW)

| Step | Description                                                                                  |
| ---- | -------------------------------------------------------------------------------------------- |
| 1️⃣  | EC2 in private subnet sends request to `8.8.8.8` (Google DNS)                                |
| 2️⃣  | Route table sends traffic to **NAT Gateway**                                                 |
| 3️⃣  | NAT Gateway **changes source IP** from private (e.g., `10.0.1.10`) to **NAT GW’s public IP** |
| 4️⃣  | Internet sees request from NAT GW IP                                                         |
| 5️⃣  | Response comes to NAT GW, which **translates back to EC2 IP** and forwards it                |
| ✅    | EC2 receives the reply — but **remains private** to the internet                             |

---

### ✅ SNAT Example (AWS)

| From              | To                          | NAT Function                                         |
| ----------------- | --------------------------- | ---------------------------------------------------- |
| `10.0.1.10:45678` | `8.8.8.8:53`                | NAT GW changes `10.0.1.10 → 3.111.22.33` (public IP) |
| Response          | `3.111.22.33` → `10.0.1.10` | NAT GW reverses translation                          |

---

## 🔃 DNAT Example (not supported by NAT GW)

> DNAT is used when **public users access internal systems**, like **port forwarding**.

💡 In AWS, **DNAT is handled by**:

* **Elastic Load Balancer (ELB)**
* **Custom NAT instances** (advanced use cases)

🧪 Example of DNAT:

* Public user hits `13.34.56.78:80` → NAT translates destination IP to `10.0.1.20:80` (internal web server)

---

## 🔐 NAT GW vs IGW

| Feature         | NAT Gateway                               | Internet Gateway                 |
| --------------- | ----------------------------------------- | -------------------------------- |
| Use Case        | Private subnet → Internet (outbound only) | Public subnet → 2-way internet   |
| Supports SNAT   | ✅ Yes                                     | ❌ No                             |
| Supports DNAT   | ❌ No                                      | ✅ For public subnets             |
| Needs public IP | ✅ NAT GW has Elastic IP                   | ✅ Used for public-facing traffic |

---

## 🧠 Interview One-Liner:

> **"NAT translates private IPs to public IPs so that internal systems can access external networks securely. SNAT handles outbound traffic (like AWS NAT Gateway), and DNAT handles inbound mapping (like port forwarding). In AWS, NAT Gateway performs SNAT to give private subnet EC2s internet access without exposing them."**

---
