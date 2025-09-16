## 1️⃣ FreeStyle Jobs

**What it is:**

* The **classic Jenkins job** type.
* Everything is configured via the Jenkins **UI** (web interface).
* You manually define **build steps, triggers, post-build actions**.

**Pros:**

* Easy to start with, simple UI-based setup.
* Good for small projects or one-off jobs.

**Cons:**

* Hard to version control.
* Not great for complex workflows (parallel builds, conditional steps, etc.).
* Not easy to share or reuse configurations.

**Use case:**

* Quick scripts, simple tasks, small teams.
* Example: Run a backup script every night, trigger a simple build.

---

## 2️⃣ Pipeline as Code (Declarative & Scripted Pipelines)

This is **Jenkins’ modern approach**, using a **Jenkinsfile** stored in your source repository.

### a) Declarative Pipeline

* **Simpler, more structured syntax.**
* Introduced to **make pipelines easier to read and maintain**.
* You define `pipeline { ... }` blocks with **stages, steps, post, triggers, environment, etc.**
* Supports **built-in features** like `when`, `input`, `parallel`, `tools`.

**Pros:**

* Clean and readable.
* Best practice for modern CI/CD.
* Works well with **shared libraries**.
* Can version control your pipeline alongside code.

**Cons:**

* Less flexible for highly dynamic workflows (though you can use `script {}` blocks to add Groovy).

**Use case:**

* Most modern CI/CD pipelines, deployments, multi-stage workflows.
* Example: Build → Test → Deploy → Notify, with parameters, triggers, and environment variables.

---

### b) Scripted Pipeline

* **Old-style pipeline using full Groovy syntax**.
* Fully **imperative**: you write the logic exactly as Groovy code (`node { ... }`).
* More flexible than declarative pipelines.

**Pros:**

* Can implement **complex, dynamic workflows**.
* Full Groovy power.

**Cons:**

* Harder to read for non-Groovy users.
* Harder to maintain in large teams.

**Use case:**

* Advanced pipelines that need loops, dynamic stages, or custom logic not easily done in declarative syntax.

---

## 3️⃣ Quick Comparison Table

| Feature                    | FreeStyle Jobs        | Declarative Pipeline     | Scripted Pipeline          |
| -------------------------- | --------------------- | ------------------------ | -------------------------- |
| **Definition**             | UI-based              | Jenkinsfile (structured) | Jenkinsfile (Groovy)       |
| **Version Control**        | ❌ Not versioned       | ✅ Versioned              | ✅ Versioned                |
| **Complex Workflow**       | ❌ Limited             | ✅ Good                   | ✅ Excellent                |
| **Ease of Maintenance**    | ❌ Hard for large jobs | ✅ Easy                   | ❌ Harder                   |
| **Parallel / Conditional** | ❌ Limited             | ✅ Built-in support       | ✅ Fully flexible           |
| **Use Case**               | Simple scripts/tasks  | Standard CI/CD           | Advanced dynamic pipelines |

---

### ✅ Rule of Thumb

1. **FreeStyle** → Quick, small jobs, no version control needed.
2. **Declarative Pipeline** → Standard CI/CD pipelines, best for most projects.
3. **Scripted Pipeline** → Complex workflows needing full Groovy flexibility.

---

### **1. Jenkins Pipelines**

Jenkins Pipeline is a way to **define your build, test, and deploy process as code**. Instead of manually configuring jobs, you write them in a file (usually called `Jenkinsfile`). There are two main types:

#### **a) Declarative Pipeline**

* Easier, structured syntax.
* Uses `pipeline { }` block.
* Recommended for most use cases.

**Example:**

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
            }
        }
    }
}
```

#### **b) Scripted Pipeline**

* More flexible, uses Groovy scripting.
* Syntax is less strict.
* Good for complex logic.

**Example:**

```groovy
node {
    stage('Build') {
        echo 'Building the application...'
    }
    stage('Test') {
        echo 'Running tests...'
    }
    stage('Deploy') {
        echo 'Deploying the application...'
    }
}
```

---

# Declarative Pipeline Syntax Example
Sure! Let’s go step by step with **Declarative Pipeline syntax** in Jenkins, including **all the elements you listed**, with simple examples. I’ll keep it clear and practical.

---

```groovy
pipeline {
    // 1️⃣ Agent
    agent { 
        label 'linux'  // Run on nodes with label 'linux'
    }

    // 6️⃣ Environment
    environment {
        APP_NAME = "MyApp"
        VERSION = "1.0"
    }

    // 4️⃣ Parameters
    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: 'Environment to deploy')
        booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run tests before deployment')
    }

    // 3️⃣ Options
    options {
        timeout(time: 30, unit: 'MINUTES')    // Pipeline timeout
        buildDiscarder(logRotator(numToKeepStr: '5')) // Keep last 5 builds
    }

    // 7️⃣ Triggers
    triggers {
        cron('H/15 * * * *')  // Poll SCM every 15 minutes
    }

    // 2️⃣ Stages
    stages {

        stage('Checkout') {  // Stage
            steps {          // Steps
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building ${env.APP_NAME} version ${env.VERSION}"
                sh 'echo Build command here'
            }
        }

        stage('Test') {
            when {
                expression { params.RUN_TESTS } // 10️⃣ When
            }
            steps {
                echo "Running tests..."
                sh 'echo Test command here'
            }
        }

        stage('Deploy') {
            input {  // 9️⃣ Input
                message "Deploy to ${params.DEPLOY_ENV}?"
                ok "Deploy Now"
            }
            steps {
                echo "Deploying to ${params.DEPLOY_ENV} environment"
                sh 'echo Deploy command here'
            }
        }

        stage('Parallel Example') {  // 11️⃣ Parallel
            parallel {
                stage('Task 1') {
                    steps { echo 'Running Task 1 in parallel' }
                }
                stage('Task 2') {
                    steps { echo 'Running Task 2 in parallel' }
                }
            }
        }

    }

    // 5️⃣ Post actions
    post {
        success {
            echo "Pipeline succeeded!"
        }
        failure {
            echo "Pipeline failed!"
        }
        always {
            echo "This runs regardless of result"
        }
    }

    // 8️⃣ Tools
    tools {
        maven 'Maven3'  // Use configured Maven tool
        jdk 'JDK11'     // Use configured JDK
    }
}
```

---

### ✅ Explanation

| Element         | Example in pipeline                                      |
| --------------- | -------------------------------------------------------- |
| **Agent**       | `agent { label 'linux' }`                                |
| **Stages**      | `stages { stage('Build') { steps { ... } } }`            |
| **Options**     | `timeout`, `buildDiscarder`                              |
| **Parameters**  | `string`, `booleanParam`                                 |
| **Post**        | `success`, `failure`, `always`                           |
| **Environment** | `APP_NAME = "MyApp"`                                     |
| **Triggers**    | `cron`                                                   |
| **Tools**       | `maven 'Maven3'`, `jdk 'JDK11'`                          |
| **Input**       | `input { message "Deploy?" ok "Yes" }`                   |
| **When**        | `when { expression { params.RUN_TESTS } }`               |
| **Parallel**    | `parallel { stage('Task1') {...} stage('Task2') {...} }` |

---