# VM based Architecture

```
www.vm.ullagallu.in (DNS)
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
---

- CI/CD: Jenkins
- Cloud: AWS
- Packer: AMI Baking
- Terraform: Infra Automation
- CloudWatch: Monitoring & Logging
- AWS Secrets Manager: Secrets Management

---
