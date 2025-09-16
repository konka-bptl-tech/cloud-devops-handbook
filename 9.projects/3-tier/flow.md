# VM based Architecture

```
www.vm.konkas.tech (DNS)
          ↓
CloudFront (CDN, SSL, WAF, Caching)
          ↓
External ALB (Public ALB)
          ↓
Frontend (ReactJS on VM, ASG)
          ↓
Internal ALB (Private ALB)
          ↓
Backend (NodeJS on VM, ASG)
      ↘      ↘
   ElastiCache  ↓
        ↘     ↓
           RDS (Database)

```
- CI/CD: Jenkins Pipelines
- Packer: AMI Build
- Terraform: Infra Automation
- Prometheus&Grafana: Metrics
- Elastic Stack: Logs
- AWS Secrets Manager: Secrets Management
---





# AWS Services
1. VPC & Componetns
2. IAM 
3. ACM
4. ELB
5. ASG
6. CloudFront
7. R53
8. RDS
9. ElasticCache
10. ParameterStore
11. SecretsManager
12. SG

# Terraform 
1. Automate Infrastructure
2. Modules
   - VPC
   - SG
   - IAM
   - ACM
   - RDS
   - ElasticCache
   - ELB & Components
   - ASG & Components

# CI/CD 
- Jenkins
- OwaspDependency Check[SCA]
- Nexus/S3
- Sonarqube

# CI/CD Tasks
1. build pipeline for gold image
2. build CI/CD pipeline for application build and deploy
3. build pipeline for infrastructure

# Ansible Roles
- prometheus & grafana
- node exporter
- Elastic Stack
- Backend Golden Image
- Forntend Golden Image

# Packer
1. Golden AMI for frontend & backend
- Pass ansible-role for Creating Backend Golden AMI
- Test the Backend AMI 

- Pass ansible-role for Creating Frontend Golden AMI
- Test the Frontend AMI 

# Monitoring & Logging
1. Prometheus & Grafana
2. ELastic Stack
- Launch Ec2 machie for prometheus & grafana
- pass the ansible playbook through userdata to install & setup prometheus & grafana

- Launch Ec2 machie for Elastic Stack
- pass the ansible playbook through userdata to install & setup Elastic Stack
