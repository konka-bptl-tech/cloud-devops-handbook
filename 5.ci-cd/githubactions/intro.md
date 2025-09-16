**GitHub Actions** is a **CI/CD (Continuous Integration and Continuous Deployment) tool built into GitHub**. It allows you to **automate workflows** like building, testing, and deploying your code whenever certain events happen in your repository (e.g., push, pull request, release).

---

### ✅ **Key Points**

* It is **event-driven** → triggers on events like `push`, `pull_request`, `schedule`, or even manual runs (`workflow_dispatch`).
* Runs on **GitHub-hosted runners** (Ubuntu, Windows, macOS) or **your own self-hosted runners**.
* Uses **YAML files** inside `.github/workflows/` directory to define automation.

---

### ✅ **Why use GitHub Actions?**

* Automates build, test, and deploy pipelines.
* Integrates deeply with GitHub repositories.
* Free minutes for public repos, paid for private repos (with limits).
* Supports **Docker**, **containers**, and **matrix builds** (run on multiple OS or versions).

---

### ✅ **Basic Structure**

A **workflow** file contains:

* **name:** Name of the workflow.
* **on:** Event that triggers it.
* **jobs:** Tasks to perform.
* **steps:** Commands or actions inside a job.

Example:

```yaml
name: CI Example
on: push
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run a script
        run: echo "Hello from GitHub Actions"
```
---

### ✅ **1. Basic Definition**

* **GitHub Actions:**
  A **CI/CD service integrated directly into GitHub**. You define workflows in `.github/workflows/` using YAML. It’s cloud-native and easy for GitHub projects.

* **Jenkins:**
  An **open-source automation server**. You install and maintain it on your own server (or use Jenkins in Kubernetes). Supports thousands of plugins and can integrate with any VCS (GitHub, GitLab, Bitbucket).

---

### ✅ **2. Hosting**

* **GitHub Actions:**
  Fully managed by GitHub (with GitHub-hosted runners). You can also use **self-hosted runners**.

* **Jenkins:**
  You **host and maintain it yourself** (on VM, container, or Kubernetes). Needs manual scaling and maintenance.

---

### ✅ **3. Configuration**

* **GitHub Actions:**
  YAML-based, stored in the repository under `.github/workflows/`.
  Example:

  ```yaml
  on: push
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - run: echo "Hello GitHub Actions"
  ```

* **Jenkins:**
  Can use **Jenkins UI** or **Jenkinsfile** (Groovy DSL).
  Example:

  ```groovy
  pipeline {
    agent any
    stages {
      stage('Build') {
        steps {
          echo 'Hello Jenkins'
        }
      }
    }
  }
  ```

---

### ✅ **4. Plugins & Marketplace**

* **GitHub Actions:**
  Has a **marketplace** with pre-built actions.

* **Jenkins:**
  Has **thousands of plugins** for almost anything (build tools, SCM, notifications).

---

### ✅ **5. Cost**

* **GitHub Actions:**
  Free for public repos, limited free minutes for private repos, then paid.

* **Jenkins:**
  Free (open-source), but you pay for the infrastructure and maintenance.

---

### ✅ **6. Scalability**

* **GitHub Actions:**
  Scales automatically with GitHub-hosted runners.

* **Jenkins:**
  Requires setting up **master-agent architecture** for scaling.

---

### ✅ **7. Ecosystem**

* **GitHub Actions:** Best if your code is in **GitHub** (tight integration).
* **Jenkins:** Best for **complex pipelines**, multiple repositories, and when you need full control.

---

#### **Summary Table**

| Feature     | GitHub Actions           | Jenkins                  |
| ----------- | ------------------------ | ------------------------ |
| Hosting     | Cloud (or self-hosted)   | Self-hosted (you manage) |
| Config File | YAML (.github/workflows) | Jenkinsfile (Groovy)     |
| Integration | Best with GitHub         | Any Git provider         |
| Scaling     | Auto with GitHub         | Manual (master-agent)    |
| Cost        | Free/paid                | Free, but infra cost     |

---