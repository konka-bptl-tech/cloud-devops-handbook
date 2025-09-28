# Serverless-Hosted Architecture

```
ecs.ullagallu.in (DNS - Route53 or similar)
    ↓
CloudFront (CDN + SSL + WAF + Caching)
    ↓
Frontend (ReactJS static files hosted on S3, CORS enabled)
    ↓
Internal ALB (Private)
    ↓
Backend (NodeJS app running on ECS - Fargate or EC2 launch type)
    ↘          ↘
   ElastiCache  ↓
        ↘     ↓
           RDS (Database)
```
---

- CI/CD : GithubActions
- Cloud: AWS
- Docker: Containerization
- Terraform: InfraStructure
- Observability: CloudWatch
- AWS Secrets Manager: Secrets management

---