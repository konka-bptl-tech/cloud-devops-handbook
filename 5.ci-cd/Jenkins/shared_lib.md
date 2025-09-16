## ✅ **What is Jenkins Shared Library?**

* A **reusable code library** for Jenkins pipelines.
* Helps follow **DRY principle** (Don’t Repeat Yourself).
* Instead of writing the same pipeline code in multiple Jenkinsfiles, you **centralize it** in one shared library and reuse it.

---

## ✅ **Why use it?**

* **Consistency**: Same logic for all projects.
* **Easy maintenance**: Update in one place, applies everywhere.
* **Modularity**: Organize common functions.

---

## ✅ **Structure of a Shared Library**

Example Git repo structure for the library:

```
jenkins-shared-lib/
├── vars/
│   └── sayHello.groovy
├── src/
│   └── org/example/Utils.groovy
└── resources/
```

### Explanation:

* **vars/** → For simple reusable steps (global functions).
* **src/** → For complex Groovy classes.
* **resources/** → For external files (templates, configs).

---

## ✅ **Step 1: Create a Simple Function**

Create `vars/sayHello.groovy`:

```groovy
def call(String name = 'World') {
    echo "Hello, ${name}!"
}
```

This means we have a reusable function called `sayHello`.

---

## ✅ **Step 2: Configure in Jenkins**

1. Go to **Manage Jenkins → Configure System → Global Pipeline Libraries**.
2. Add:

   * Name: `shared-lib`
   * Source Code Management: Git
   * Repository URL: `https://github.com/your-org/jenkins-shared-lib.git`
   * Default version: `main`

---

## ✅ **Step 3: Use in Jenkinsfile**

```groovy
@Library('shared-lib') _
pipeline {
    agent any
    stages {
        stage('Greet') {
            steps {
                sayHello('Konka')
            }
        }
    }
}
```

**What happens?**

* Jenkins loads `shared-lib`.
* Calls `sayHello('Konka')` → prints **Hello, Konka!**

---

### ✅ **Advanced Example with src/**

If you have a utility class:
`src/org/example/Utils.groovy`

```groovy
package org.example

class Utils {
    static void printMessage(String msg) {
        println "Message: ${msg}"
    }
}
```

Call in Jenkinsfile:

```groovy
@Library('shared-lib') _
import org.example.Utils

pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                script {
                    Utils.printMessage('Build Started!')
                }
            }
        }
    }
}
```

---

✅ **Benefits in real projects**:

* Use shared functions for:

  * Common steps like `build()`, `deploy()`, `notifySlack()`.
  * Managing credentials.
  * Complex logic (dynamic environments).

---

# Example-1[simple]

---

### ✅ **Shared Library Structure**

```
jenkins-shared-lib/
├── vars/
│   ├── buildApp.groovy
│   ├── deployApp.groovy
│   └── notifySlack.groovy
└── src/
    └── org/example/Utils.groovy
```

---

### ✅ **Step 1: Create Common Functions in `vars/`**

#### **1. buildApp.groovy**

```groovy
def call() {
    echo "Building the application..."
    sh 'mvn clean package'  // Example for Java
}
```

#### **2. deployApp.groovy**

```groovy
def call(String environment) {
    echo "Deploying application to ${environment}..."
    sh "kubectl apply -f k8s/${environment}/deployment.yaml"
}
```

#### **3. notifySlack.groovy**

```groovy
def call(String message) {
    echo "Sending Slack Notification: ${message}"
    // Slack integration logic can go here
}
```

---

### ✅ **Step 2: Configure Shared Library in Jenkins**

* Go to **Manage Jenkins → Configure System → Global Pipeline Libraries**.
* Add:

  * Name: `shared-lib`
  * SCM: Git (point to the repo where the above code is stored).

---

### ✅ **Step 3: Jenkinsfile Using the Library**

```groovy
@Library('shared-lib') _

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                buildApp()
            }
        }

        stage('Deploy') {
            steps {
                deployApp('dev') // Deploy to dev environment
            }
        }

        stage('Notify') {
            steps {
                notifySlack('Build and Deploy Completed Successfully!')
            }
        }
    }
}
```

---

### ✅ **What Happens**

* Jenkins loads **shared-lib**.
* Calls:

  * `buildApp()` → Runs Maven build.
  * `deployApp('dev')` → Applies Kubernetes manifest for dev.
  * `notifySlack()` → Sends a notification.

---

### ✅ **Advantages**

* If you have **10 microservices**, all can use the **same Jenkinsfile**, just different environment values.
* Update logic (like deployment steps) **in one place**, and all pipelines get the update.

---

# Example-2

---

## ✅ **Updated Shared Library Structure**

```
jenkins-shared-lib/
├── vars/
│   ├── buildApp.groovy
│   ├── deployApp.groovy
│   └── notifySlack.groovy
└── src/
    └── org/example/Utils.groovy
```

---

### ✅ **Step 1: Update Functions to Accept Parameters**

#### **1. buildApp.groovy**

```groovy
def call(String buildTool = 'maven') {
    echo "Building the application using ${buildTool}..."
    if (buildTool == 'maven') {
        sh 'mvn clean package'
    } else if (buildTool == 'gradle') {
        sh './gradlew build'
    } else {
        error "Unsupported build tool: ${buildTool}"
    }
}
```

---

#### **2. deployApp.groovy**

```groovy
def call(String environment, String appName, String imageTag) {
    echo "Deploying ${appName} to ${environment} with image tag ${imageTag}..."
    
    if (environment == 'prod') {
        echo "Running additional production checks..."
        // Add extra steps for prod if needed
    }
    
    sh """
    kubectl set image deployment/${appName} ${appName}=myrepo/${appName}:${imageTag} -n ${environment}
    """
}
```

---

#### **3. notifySlack.groovy**

```groovy
def call(String message, String color = 'good') {
    echo "Sending Slack Notification: ${message} with color: ${color}"
    // Integration with Slack plugin can go here
}
```

---

### ✅ **Step 2: Jenkinsfile Using Parameters**

```groovy
@Library('shared-lib') _

pipeline {
    agent any
    parameters {
        string(name: 'ENV', defaultValue: 'dev', description: 'Deployment Environment')
        string(name: 'APP_NAME', defaultValue: 'myapp', description: 'Application Name')
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker Image Tag')
    }

    stages {
        stage('Build') {
            steps {
                buildApp('maven') // Pass build tool
            }
        }

        stage('Deploy') {
            steps {
                deployApp(params.ENV, params.APP_NAME, params.IMAGE_TAG)
            }
        }

        stage('Notify') {
            steps {
                script {
                    if (params.ENV == 'prod') {
                        notifySlack("Production deployment completed for ${params.APP_NAME}", "danger")
                    } else {
                        notifySlack("Deployment completed for ${params.APP_NAME} in ${params.ENV}", "good")
                    }
                }
            }
        }
    }
}
```

---

### ✅ **What’s New Here**

✔ **Dynamic Parameters**:

* ENV (dev, staging, prod)
* APP\_NAME (microservice name)
* IMAGE\_TAG (build version)

✔ **Conditional Logic**:

* If ENV = prod → extra checks + Slack alert in red color.

✔ **Shared Library Handles Parameters**:

* Build tool selection (Maven or Gradle).
* Deployment logic with app name and tag.

---

### ✅ **Advantages**

* One Jenkinsfile works for **all environments and microservices**.
* Shared library keeps your **business logic clean** and **DRY**.
* Easy to maintain and scale.

---

# Example-3

---

## ✅ **Updated Shared Library Structure**

```
jenkins-shared-lib/
├── vars/
│   ├── buildApp.groovy
│   ├── deployApp.groovy
│   └── notifySlack.groovy
└── src/org/example/
    └── Utils.groovy
```

---

### ✅ **Step 1: Add `Utils.groovy` in `src/org/example/`**

```groovy
package org.example

class Utils implements Serializable {

    // Generate timestamp-based version
    static String getTimestamp() {
        return new Date().format("yyyyMMdd-HHmmss")
    }

    // Get short Git commit hash
    static String getGitCommitHash() {
        return "git rev-parse --short HEAD".execute().text.trim()
    }

    // Combine app name with timestamp for image tag
    static String generateImageTag(String appName) {
        return "${appName}-${getTimestamp()}"
    }
}
```

---

### ✅ **Step 2: Update `deployApp.groovy` to Use Utils**

```groovy
import org.example.Utils

def call(String environment, String appName, String imageTag = '') {
    if (!imageTag) {
        imageTag = Utils.generateImageTag(appName)
    }

    echo "Deploying ${appName} to ${environment} with image tag ${imageTag}..."

    if (environment == 'prod') {
        echo "Running additional production checks..."
    }

    sh """
    kubectl set image deployment/${appName} ${appName}=myrepo/${appName}:${imageTag} -n ${environment}
    """
}
```

---

### ✅ **Step 3: Jenkinsfile Using Utils**

```groovy
@Library('shared-lib') _
import org.example.Utils

pipeline {
    agent any
    parameters {
        string(name: 'ENV', defaultValue: 'dev', description: 'Deployment Environment')
        string(name: 'APP_NAME', defaultValue: 'myapp', description: 'Application Name')
    }

    stages {
        stage('Build') {
            steps {
                script {
                    buildApp('maven')
                }
            }
        }

        stage('Generate Tag') {
            steps {
                script {
                    env.IMAGE_TAG = Utils.generateImageTag(params.APP_NAME)
                    echo "Generated image tag: ${env.IMAGE_TAG}"
                }
            }
        }

        stage('Deploy') {
            steps {
                deployApp(params.ENV, params.APP_NAME, env.IMAGE_TAG)
            }
        }

        stage('Notify') {
            steps {
                script {
                    def commit = Utils.getGitCommitHash()
                    def msg = "Deployment for ${params.APP_NAME} (${commit}) to ${params.ENV} completed successfully with tag ${env.IMAGE_TAG}"
                    notifySlack(msg)
                }
            }
        }
    }
}
```

---

### ✅ **What’s New**

✔ **Utils class provides**:

* Timestamp-based versioning.
* Git commit hash.
* Dynamic image tags.

✔ **Dynamic Image Tagging**:

* If user does not provide `IMAGE_TAG`, system generates one automatically.

✔ **More Professional Workflow**:

* Build → Generate Tag → Deploy → Notify (with Git commit info).

---

### ✅ **Advantages**

* Cleaner and DRY Jenkinsfile.
* All helper logic is in **Utils**, easy to update in one place.
* Works for multiple projects without duplication.

---
