# Tasks 
C  - Completed
P  - Progression

No signs = On Cards

# Manually Check the Application flow no need to setup complete flow[C]
   - Launch RDS[MySQl]
   - Launch Valkey
   - Create Packer AMI for Backend & Frontend
   - Store Non-sensitive data on parameter store
   - Store Sensitive data on Secrets Manager
   - Create IAM Role & policy  for backend to access parameter store and Secrets Manager
   - Lauch Backend Server with Already backend baked AMI with IAM role
   - Store nginx configuration on s3 bucket
   - Create IAM Role & Policy from frontend to access s3 bucket
   - Launch Frontend Server with Already frotnend baked AMI with IAM role
2. Ensure AutoScaling & LB capabilties[C]
   - Create Launch Tempalte for backend and frontend
   - Create Backend ALB[internal] and Frontend ALB[external]
   - Launch Backend Server
   - Launch Frontend Server


# Now Automate infrastructure using Terraform Create Modules and Call it
1. IAM[C]
2. ACM[C]
3. CloudWatch
4. Create VPC[C]
   - Create VPC
   - 2 public,private and db subnets
   - IGW
   - RT for public,private and DB and associate subnets
   - EIP
   - NATGW
   - Add routing Rules in private and db RT
   - VPC flow logs
     - Create CloudWatch Log Group and appropriate IAM role and policy
   - VPC peering default and this VPC
5. SG[C]
6. EC2[C]
7. RDS[C]
8. Elastic Cache[C]
9. ALB[C]
   - ALB Access Logs[p]
   - ALB Connection Logs[P] 
10. ASG[C]
11. CloudFront[C]
   - Create S3 bucket for storing logs
   - Create IAM role and policy
13. Athena Module   
# CI/CD pipelines

1. Jenkin Master Slave Setup
2. Install necessary plugins
3. Organize pipelines using folder
4. Create Backend CI/CD Pipeline
5. Create Frontend CI/CD Pipeline
6. Shared Libs for backend and frontend pipelines

Note: Blue-Green Deployment Strategy 


---
Perfect! Here’s a **refined checklist version** of your project setup incorporating the improvements and best practices. I’ve kept it simple and actionable so you can use it directly while implementing.

---

# **3-Tier AWS Project Setup Checklist**

**Legend:**
C – Completed
P – In Progress
No sign – To do

---

## **1. Manual Setup & Verification**

* [C] Launch RDS (MySQL) – multi-AZ recommended
* [C] Launch Valkey / Redis replacement
* [C] Create Packer AMI for Backend & Frontend
* [C] Store non-sensitive data in Parameter Store
* [C] Store sensitive data in Secrets Manager (enable versioning)
* [C] Create IAM Role & Policy for backend to access Parameter Store & Secrets Manager
* [C] Launch backend server with baked AMI + IAM role
* [C] Store nginx configuration on S3
* [C] Create IAM Role & Policy for frontend to access S3
* [C] Launch frontend server with baked AMI + IAM role
* [P] Verify manual application flow and basic functionality
* [P] Health check backend/frontend endpoints

---

## **2. AutoScaling & Load Balancer**

* [C] Create Launch Templates for backend & frontend
* [C] Create Backend ALB (internal)
* [C] Create Frontend ALB (external)
* [C] Launch backend/frontend servers using ALB target groups
* [P] Enable ALB Access Logs → S3 + Athena for queries
* [P] Enable ALB Connection Logs (if needed)
* [P] Configure ALB health checks & sticky sessions (if required)

---

## **3. Terraform Automation**

### **Modules**

* [C] IAM
* [C] ACM
* [C] VPC

  * [C] Create VPC
  * [C] Create public, private, DB subnets
  * [C] IGW, NATGW, EIP
  * [C] Route tables & associations
  * [P] Enable VPC Flow Logs → CloudWatch
  * [P] Create VPC peering if needed
* [C] Security Groups
* [C] EC2
* [C] RDS – multi-AZ & backups enabled
* [C] Elastic Cache / Valkey – multi-AZ & backups
* [C] ALB – internal & external

  * [P] ALB logging (Access & Connection)
* [C] ASG – auto-scaling groups
* [C] CloudFront – attach S3, enable logging
* [P] Athena module – for querying logs
* [P] CloudWatch – dashboards & alarms for:

  * EC2 (CPU, memory, disk)
  * RDS metrics (CPU, connections, latency)
  * Cache metrics
  * ALB metrics (5XX errors, latency, request count)

**Notes:**

* Use Terraform remote backend (S3 + DynamoDB) for state management.
* Tag all resources for environment, team, and project.

---

## **4. CI/CD Pipelines**

* [C] Jenkins Master/Slave setup
* [C] Install required plugins
* [C] Organize pipelines using folders
* [C] Create backend CI/CD pipeline
* [C] Create frontend CI/CD pipeline
* [C] Shared libraries for pipelines
* [P] Integrate Terraform plan/apply for infrastructure changes
* [P] Include Blue-Green deployment strategy
* [P] Automatic rollback on deployment failure
* [P] Linting/unit tests for code and IaC templates
* [P] Post-deployment verification steps

---

## **5. Monitoring & Logging**

* [P] CloudWatch dashboards for backend/frontend/DB/cache metrics
* [P] Enable ALB access & connection logs → S3 → Athena
* [P] CloudFront logging → S3 → Athena
* [P] Setup CloudWatch alarms and notifications

---

✅ **Optional Enhancements:**

* Enable **Terraform workspaces** for multiple environments (dev/staging/prod)
* Use **versioned S3 buckets** for logs and nginx configs
* Integrate **SNS / Slack notifications** for critical alerts
* Add **cost monitoring alerts** in CloudWatch or Cost Explorer

---

