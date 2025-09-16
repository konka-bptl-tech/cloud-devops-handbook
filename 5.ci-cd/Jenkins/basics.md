# Jenkins Installation steps
1. java
2. install jenkins from official website
# What is Jenkins
# Jenkins Master Slave architecture
- Distributed Architecture
### Master
1. Provides the Jenkins UI and configuration.
2. Handles job scheduling (decides which job runs on which node).
3. Stores build configurations, plugins, and job history.
4. Avoid building jobs
### Slave
1. Executes the actual build jobs assigned by the master.
2. Can run on different OS, hardware, or environments.
3. Reports the build status back to the master.

It’s mainly for load distribution, parallel execution, and cross-platform builds.

# Upstream and Down stream jobs
### **Upstream Job**

A job that triggers another job after it finishes.
Example: **Build job** → triggers **Test job**.
Here, **Build job is the upstream**.

### **Downstream Job**

A job that is triggered by another job.
Example: **Test job** (triggered by Build job).
Here, **Test job is the downstream**.

✅ **In short:**

* **Upstream = the job that triggers.**
* **Downstream = the job that gets triggered.**
