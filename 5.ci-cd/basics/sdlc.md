## **1. SDLC (Software Development Life Cycle)**

**Definition:**
SDLC is a **structured process for developing software** from concept to deployment and maintenance. It ensures software is delivered **efficiently, with quality, and within time and budget**.

**Phases of SDLC:**

1. **Requirement Analysis** – Gather and document business and technical requirements.
2. **Design** – Create architecture and design specifications.
3. **Implementation (Coding)** – Developers write the code.
4. **Testing** – Verify software works as expected and is bug-free.
5. **Deployment** – Release the software to production.
6. **Maintenance** – Fix issues, update features, and optimize performance.

**Key Point:** SDLC ensures **structured development** and reduces errors during software delivery.

---

## **2. Waterfall Model**

**Definition:**
Waterfall is a **linear and sequential SDLC model** where each phase must be completed before moving to the next.

**Characteristics:**

* Phases follow one after another: Requirements → Design → Implementation → Testing → Deployment → Maintenance.
* Changes are difficult to accommodate once a phase is completed.
* Works well for projects with **well-defined requirements**.

**Advantages:**

* Simple and easy to manage.
* Clear documentation for each phase.

**Disadvantages:**

* Inflexible to changes.
* Late testing can lead to costly fixes.

---

## **3. Agile Methodology**

**Definition:**
Agile is an **iterative and incremental development methodology** focusing on **collaboration, flexibility, and frequent delivery**.

**Key Principles:**

* Work is divided into **sprints** (1–2 weeks).
* Continuous collaboration with developers, QA, and stakeholders.
* Frequent delivery of **working software** for feedback.
* Regular **retrospectives** to improve processes.

**Popular Agile Frameworks:**

* **Scrum** – Uses roles like Scrum Master, Product Owner, and development team. Focuses on sprints, daily standups, and backlog.
* **Kanban** – Visual board to track tasks, emphasizes **continuous delivery** without fixed sprints.

---

## **4. DevOps**

**Definition:**
DevOps is a **culture and set of practices** that **bridges development (Dev) and operations (Ops)** to deliver software faster and more reliably.

**Key Goals:**

* Automate the software lifecycle (build, test, deploy).
* Improve collaboration between development and operations teams.
* Ensure **continuous delivery and monitoring**.

**Common Tools:**

* **CI/CD:** Jenkins, GitHub Actions, GitLab CI, Argo CD
* **Infrastructure as Code:** Terraform, CloudFormation
* **Containerization:** Docker, Kubernetes

**Key Point:** DevOps reduces **time-to-market** and improves software reliability.

---

## **5. CI/CD (Continuous Integration / Continuous Deployment)**

**Definition:**
CI/CD is a **DevOps practice** to automate building, testing, and deploying code.

**Continuous Integration (CI):**

* Developers **merge code frequently** into a shared repository.
* Automated builds and tests run to catch issues early.
* Tools: Jenkins, GitHub Actions, GitLab CI

**Continuous Deployment / Delivery (CD):**

* **Continuous Delivery:** Code changes are automatically tested and ready to deploy.
* **Continuous Deployment:** Code changes are automatically deployed to production after passing tests.
* Tools: Argo CD, Spinnaker, Jenkins

**Benefits:**

* Faster feedback.
* Fewer bugs in production.
* Automated release process reduces human error.

---

## **6. DevSecOps**

**Definition:**
DevSecOps integrates **security practices into DevOps** from the start instead of as a separate step.

**Key Principles:**

* Security is **everyone’s responsibility**.
* Automate security checks in CI/CD pipelines.
* Continuous monitoring for vulnerabilities.

**Common Practices:**

* **Static Application Security Testing (SAST)** – Code analysis.
* **Dynamic Application Security Testing (DAST)** – Runtime analysis.
* **Dependency Scanning** – Check libraries for vulnerabilities.

**Benefits:**

* Early detection of security issues.
* Reduces risks and costs compared to post-deployment fixes.

---

## **7. GitOps**

**Definition:**
GitOps is a **DevOps approach using Git as the single source of truth** for infrastructure and application deployments.

**Key Principles:**

* **All changes are version-controlled** in Git.
* Automation tools sync Git with the production environment.
* Works mainly with **Kubernetes and cloud-native environments**.

**Tools:**

* Argo CD, Flux CD

**Benefits:**

* **Audit trail** for all changes.
* **Rollback** is easy by reverting Git commits.
* Improves consistency and reliability of deployments.

---

### ✅ **Summary Table**

| Topic     | Focus                                         | Key Tools / Concepts                                   |
| --------- | --------------------------------------------- | ------------------------------------------------------ |
| SDLC      | Structured software development               | Requirement → Design → Code → Test → Deploy → Maintain |
| Waterfall | Linear, sequential approach                   | Fixed phases, difficult to change                      |
| Agile     | Iterative, flexible development               | Scrum, Kanban, Sprints, Standups                       |
| DevOps    | Collaboration Dev + Ops                       | CI/CD, IaC, Monitoring, Containers                     |
| CI/CD     | Automated build, test, deploy                 | Jenkins, GitHub Actions, Argo CD                       |
| DevSecOps | Security integrated in DevOps                 | SAST, DAST, Dependency Scanning                        |
| GitOps    | Git-driven infrastructure and app deployments | Argo CD, Flux CD, Kubernetes                           |

---

