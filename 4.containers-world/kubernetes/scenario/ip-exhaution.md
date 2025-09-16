### ✅ **How to Explain the EKS IP Address Exhaustion Scenario**

**Question: "What will you do if EKS pods go into a Pending state due to IP exhaustion?"**

#### **Step 1: State the Problem**

"In AWS EKS, each pod gets an IP address from the subnet associated with the node. If the subnet is small or the cluster scales out, we can hit IP exhaustion, and new pods will stay in a `Pending` state."

#### **Step 2: Give a Real Example**

"For example, suppose my VPC has **CIDR 10.1.0.0/16**. I created subnets with **/28**, which gives only **16 IP addresses** per subnet (after reserving 5 AWS IPs, only 11 are usable for nodes and pods).
If I deploy 18 pods, only 16 can run, and the remaining 2 stay Pending because there are no available IPs in the subnet."

#### **Step 3: Show the Solution**

"To fix this, I **add a secondary CIDR block** to the VPC, say **10.2.0.0/16**, and then create **new subnets with a larger CIDR like /24**, which gives **251 usable IPs** per subnet. After attaching these subnets to the node group or creating a new node group in those subnets, the pods will have enough IP addresses."

#### **Step 4: Add Extra Knowledge**

"I could also enable **Prefix Delegation** for ENIs, which allows multiple IPs per ENI, or use **Amazon VPC CNI custom networking** to assign pods IPs from secondary subnets without moving nodes."

---

### ✅ **Practice Design Exercise**

Imagine you are setting up an **EKS cluster for a microservices application**:

* VPC CIDR: `10.1.0.0/16`
* Initially, you create **3 subnets**:

  * **10.1.1.0/28**
  * **10.1.2.0/28**
  * **10.1.3.0/28**
* You launch a node group in these subnets with 3 nodes, and you deploy 25 pods.

**Questions to Answer:**

1. How many IP addresses are available per subnet? (Explain the AWS 5 IP reservation rule)
2. Why will some pods go into **Pending**?
3. If you add **secondary CIDR 10.2.0.0/16** and create **3 subnets with /24**, how many IPs will each subnet have?
4. How will you modify the node group or networking so that new pods can use these IPs?
5. What alternative solutions exist besides adding secondary CIDR? (Hint: Prefix delegation, CNI custom networking)

---

### ✅ **Sample Answer for the Design Exercise**

**Question:** *Your EKS cluster has VPC CIDR `10.1.0.0/16`, and subnets `10.1.1.0/28`, `10.1.2.0/28`, `10.1.3.0/28`. You launch a node group and deploy 25 pods. Some pods are in `Pending`. How do you fix this?*

---

**Step 1: Calculate IPs per subnet**
"A `/28` subnet provides 16 IP addresses, but AWS reserves 5 (first 4 + last 1), so only **11 usable IPs** per subnet. If each node and each pod needs an IP, these subnets are too small for scaling."

---

**Step 2: Identify the problem**
"With 3 subnets, we have only **33 IPs in total** for nodes and pods combined. When I deploy 25 pods, some stay in `Pending` because we hit IP exhaustion."

---

**Step 3: Give the solution**
"I add a **secondary CIDR block** `10.2.0.0/16` to the VPC. Then, I create 3 new subnets with `/24` size. Each `/24` provides 256 IPs, with 251 usable after AWS reservations. This gives us plenty of IPs for scaling."

---

**Step 4: Modify cluster**
"I can do one of two things:

* **Option 1:** Create a new node group in these larger subnets.
* **Option 2:** Enable **Amazon VPC CNI custom networking**, so pods can use IPs from these new subnets without moving nodes."

---

**Step 5: Alternative solutions**

* Enable **Prefix Delegation** (assign multiple IPs per ENI for more pods per node).
* Use **CNI custom networking** to separate node IP and pod IP pools.
* Optimize **pod density per node** (reduce the number of ENIs per node).

---

**Final Answer:**
"This approach ensures the cluster scales without IP exhaustion and avoids `Pending` pods."

---

### ✅ **3 More Practice Exercises (Increasing Difficulty)**

#### **Exercise 1 (Basic)**

* VPC CIDR: `172.31.0.0/16`
* Subnets: `/27` (how many usable IPs per subnet?)
* Node group: 2 nodes
* Pods deployed: 40
* **Questions:**

  1. How many pods can run before exhaustion?
  2. Why do pods go Pending?
  3. What’s your fix?

---

#### **Exercise 2 (Intermediate)**

* VPC CIDR: `10.0.0.0/16`
* Subnets: `10.0.1.0/26`, `10.0.2.0/26`
* Node group: 4 nodes
* Pods deployed: 80
* **Extra Challenge:** You cannot add new subnets. What AWS feature can you enable to fix IP exhaustion?

(Hint: Prefix delegation, CNI custom networking)

---

#### **Exercise 3 (Advanced - Real-world)**

* You have **2 environments** (Dev and Prod) in the same VPC: `192.168.0.0/16`
* Dev uses subnets `/24` (fine for now)
* Prod uses subnets `/28` (already hitting IP exhaustion)
* You cannot recreate the VPC and must **fix with zero downtime**.
* **Questions:**

  1. How do you scale Prod without impacting Dev?
  2. What AWS features or networking strategies will you use?
  3. How do you ensure security between Dev and Prod while sharing VPC?

---
