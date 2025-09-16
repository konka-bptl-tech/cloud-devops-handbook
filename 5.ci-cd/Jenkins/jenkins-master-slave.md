Good question 👍 Let’s break it down in simple technical terms.

---

## Jenkins Architecture – Control Plane (Master) and Agent (Slave) Setup

### 1. Control Plane (Jenkins Master)

* **What it does:**

  * Provides the **web UI / dashboard** for developers & DevOps engineers.
  * Stores **job configurations, pipelines, and plugins**.
  * Acts as the **central controller** that schedules jobs and assigns them to agents.
  * Maintains the **build history, logs, and metadata**.
  * Manages **security (authentication/authorization)**.

* **Why not run builds on the master?**

  * Resource contention: Master should remain responsive and stable.
  * Security: Running untrusted build code directly on master can compromise Jenkins.
  * Scalability: A single server cannot handle heavy workloads for multiple teams/projects.

---

### 2. Agent (Jenkins Slave / Worker Node)

* **What it does:**

  * Executes the actual **build, test, and deploy** steps.
  * Runs jobs assigned by the master.
  * Can be configured with **different environments/tools** (Java, Python, Docker, Kubernetes, Node.js, etc.).
  * Reports job results back to the master.

* **Why agents are needed:**

  * **Scalability** – Multiple agents allow parallel job execution.
  * **Flexibility** – Different agents can have different OS, tools, or versions.
  * **Isolation** – Failures in a build won’t crash the control plane.
  * **Efficiency** – Jobs can run on powerful build servers or in Kubernetes/ECS dynamically.

---

### 3. Communication Between Master and Agent

* Uses **Jenkins agent protocols** (JNLP, SSH, Kubernetes plugin, etc.).
* Master sends tasks → Agent executes → Results sent back to Master.

---

### 4. Reasons for Control Plane + Agent Setup

1. **Separation of concerns** → Control plane focuses on orchestration; agents focus on execution.
2. **High availability & stability** → Master stays lightweight, doesn’t get overloaded.
3. **Scalability** → Add/remove agents dynamically based on workload.
4. **Heterogeneous environments** → Build Java app on Linux, .NET on Windows, Docker builds on Linux with GPU.
5. **Security** → Restricts direct code execution on the master node.

---

👉 In short:

* **Master = Brain (scheduling, orchestration, UI, configs)**
* **Agents = Muscles (build, test, deploy execution)**

---
# Jenkins Master-Slave Setup

1. **Launch EC2 Instances**

   * Create 2 EC2 instances (1 for Master, 1 for Agent).

2. **Install Java**

   * Jenkins requires Java. Install it on both machines:

     ```bash
     sudo apt update
     apt search openjdk
     sudo apt install openjdk-21-jdk -y
     ```

3. **Install Jenkins (on Master only)**

   * Download Jenkins from the official website and install on Master machine.

4. **Add Credentials in Jenkins Master**

   * Go to:
     **Manage Jenkins > Credentials > System > Global credentials (unrestricted)**
   * Choose **SSH Username with private key**
   * Provide:

     * Username
     * Private Key
     * ID/Name

5. **Configure Agent Node**

   * Go to:
     **Manage Jenkins > Nodes > New Node**
   * Fill in:

     * **Node name**
     * **Type**: Permanent Agent
     * **Description** (optional)
     * **Remote root directory** (ex: `/home/ubuntu/jenkins`)
     * **Labels** (used in pipelines to select node)
     * **Launch method**: Launch agents via SSH
     * **Host**: Agent Private IP address
     * **Credentials**: Select the one created earlier
     * **Host Key Verification Strategy**: Non verifying

6. **Save & Test**

   * Save configuration → Jenkins Master will connect to Agent.
   * If successful, node will show as **Online**.

---


Great 👍 Here’s an extended version of your notes with a **Troubleshooting section** added at the end.

---

# Jenkins Master-Slave Setup

1. **Launch EC2 Instances**

   * Create 2 EC2 instances (1 for Master, 1 for Agent).

2. **Install Java**

   * Jenkins requires Java. Install it on both machines:

     ```bash
     sudo apt update
     apt search openjdk
     sudo apt install openjdk-21-jdk -y
     ```

3. **Install Jenkins (on Master only)**

   * Download Jenkins from the official website and install on Master machine.

4. **Add Credentials in Jenkins Master**

   * Go to:
     **Manage Jenkins > Credentials > System > Global credentials (unrestricted)**
   * Choose **SSH Username with private key**
   * Provide:

     * Username
     * Private Key
     * ID/Name

5. **Configure Agent Node**

   * Go to:
     **Manage Jenkins > Nodes > New Node**
   * Fill in:

     * **Node name**
     * **Type**: Permanent Agent
     * **Description** (optional)
     * **Remote root directory** (ex: `/home/ubuntu/jenkins`)
     * **Labels** (used in pipelines to select node)
     * **Launch method**: Launch agents via SSH
     * **Host**: Agent Private IP address
     * **Credentials**: Select the one created earlier
     * **Host Key Verification Strategy**: Non verifying

6. **Save & Test**

   * Save configuration → Jenkins Master will connect to Agent.
   * If successful, node will show as **Online**.

---

# Troubleshooting Notes

### 1. **SSH Connection Issues**

* Error: *"Failed to connect via SSH"*

  * Check security group rules: Allow port **22** between Master and Agent.
  * Verify private key matches the Agent user (`ubuntu`/`ec2-user`).
  * Test manually:

    ```bash
    ssh -i key.pem ubuntu@<agent-private-ip>
    ```

### 2. **Java Not Found on Agent**

* Error: *"java not found"*

  * Ensure Java is installed on the Agent:

    ```bash
    java -version
    ```
  * If multiple versions installed, update alternatives:

    ```bash
    sudo update-alternatives --config java
    ```

### 3. **Wrong Remote Root Directory**

* Error: *"No such directory"*

  * Create the directory on the Agent before saving node config:

    ```bash
    mkdir -p /home/ubuntu/jenkins
    chown ubuntu:ubuntu /home/ubuntu/jenkins
    ```

### 4. **Host Key Verification Failure**

* If you see key mismatch issues:

  * In node config, set **Host Key Verification Strategy = Non verifying**.
  * Or manually add Master’s SSH key to `~/.ssh/known_hosts` on Agent.

### 5. **Agent Shows Offline After Setup**

* Check Jenkins logs: **Manage Jenkins > System Log**.
* Restart the Agent machine if necessary.
* Verify Master can reach Agent private IP (check network connectivity).

---


































Perfect 👍 Let’s extend the Jenkins **Control Plane + Agent** concept into **modern Kubernetes-based setups**.

---

## Jenkins in Kubernetes – Modernized Architecture

### 1. Control Plane (Jenkins Master)

* Runs as a **Deployment/Pod** inside Kubernetes.
* Exposes a **Service** (usually NodePort/LoadBalancer or Ingress) for the Jenkins web UI.
* Stores configurations in **Persistent Volume (PV/PVC)** so Jenkins state is not lost if the pod restarts.
* Still responsible for:

  * UI, job scheduling, plugin management.
  * Deciding **which agent pod should execute which pipeline stage**.

---

### 2. Ephemeral Agents (Dynamic Worker Pods)

Instead of fixed VM-based slaves, Jenkins uses **Kubernetes plugin** to spin up agents dynamically.

* When a job is triggered:

  * Jenkins asks Kubernetes API to create a new **Pod** (agent).
  * This pod runs only for that job → then gets destroyed automatically.
* Each agent pod can have:

  * Pre-installed tools (Java, Maven, Docker, Node.js, Python, etc.).
  * Custom container images (defined per pipeline).
  * Resource limits (CPU/Memory/GPU).

---

### 3. Why This Setup Is Better

* **Elastic Scalability** – Agents scale up/down automatically based on job load.
* **Isolation** – Each job runs in its own container, no dependency conflicts.
* **Cost Efficient** – No idle agents consuming resources (unlike static VMs).
* **Multi-environment** – Different jobs use different Docker images (ex: one pod with `python:3.11`, another with `maven:3.8`).
* **Resilient** – If an agent pod crashes, Kubernetes recreates it automatically.
* **Cloud-Native** – Fits well in AWS EKS, GKE, AKS, or on-prem Kubernetes clusters.

---

### 4. Flow of Job Execution in Kubernetes

1. User pushes code → Jenkins job triggered.
2. Jenkins Control Plane (Master pod) → schedules job.
3. Kubernetes plugin requests a **new agent pod**.
4. Pod starts, connects back to Master via JNLP/SSH.
5. Job runs inside pod → results sent to Master.
6. Pod gets destroyed when job finishes.

---

### 5. Example Real-World Setup

* Jenkins Master runs as a **Deployment** in EKS.
* Persistent Volume → EBS for Jenkins home.
* Agents run as **Ephemeral Pods** with custom Docker images.
* NLB/ALB exposes Jenkins externally.
* CI/CD pipelines build Docker images and push to ECR, then deploy to EKS using Helm/Argo CD.

---

👉 So, in **classic architecture**, we had **fixed master + fixed slaves (VMs)**.
👉 In **Kubernetes architecture**, we have **lightweight master pod + on-demand disposable agent pods**.

---
