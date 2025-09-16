# 💻 Basic DevOps & Cloud Concepts
---
## 1. IP Addressing
- Subnet Mask
- CIDR (Classless Inter-Domain Routing)
- Public & Private Subnets

## 2. DNS & DHCP
- DNS (Domain Name System)
- Types of Records (A, CNAME, MX, etc.)
- DHCP (Dynamic Host Configuration Protocol)

## 3. NAT Variants
- NAT (Network Address Translation)
- SNAT (Source NAT)
- DNAT (Destination NAT)
- PNAT (Port NAT)

## 4. Protocols & Ports
- TCP / UDP
- Common Protocols & Ports
- Ephemeral Ports

## 5. Firewalls
- Stateful Firewalls
- Stateless Firewalls

## 6. Authentication vs Authorization
- Authentication = Identity validation
- Authorization = Access control

## 7. Proxy Servers
- Forward Proxy
- Reverse Proxy

## 8. Network Models
- ISO/OSI Model
- TCP/IP Model

## 9. Load Balancers
- Layer 4 (Transport Level)
- Layer 7 (Application Level)

## 10. SSL / TLS
- SSL Termination
- TLS 3-Way Handshake

## 11. Web Servers
- Nginx (Forward/Reverse Proxy, Static Hosting, Load Balancer)

## 12. Auto Scaling
- HPA (Horizontal Pod Autoscaler)
  - Scale Out / Scale In
- VPA (Vertical Pod Autoscaler)
  - Scale Up / Scale Down

## 13. Storage Types
- Block Storage (EBS)
- Object Storage (S3)
- File Storage (EFS/NFS)

## 14. Caching
- In-memory Cache (Redis, Memcached)
- CDN-based Cache (CloudFront)

## 15. RDBMS
- MySQL, PostgreSQL, SQL Server, etc.

## 16. Message Queues
- RabbitMQ, Amazon SQS, Kafka

## 17. SDLC (Software Development Life Cycle)
- Requirements → Design → Development → Testing → Deployment → Maintenance

## 18. Waterfall Model
- Sequential software development approach

## 19. Agile Methodology
- Iterative, fast delivery model with collaboration & feedback

## 20. DevOps Variants
- DevOps
- DevSecOps
- GitOps

## 21. CI / CD Concepts
- CI (Continuous Integration)
- CD (Continuous Delivery / Deployment)
- Release Strategies
- Rollback & Upgrade

## 22. Observability
- Metrics
- Logs
- Traces
- Alerting

## 23. SRE Concepts
- SLI (Service Level Indicator)
- SLO (Service Level Objective)
- SLA (Service Level Agreement)

## 24. Essential Terminology

| Term            | Meaning |
|------------------|--------|
| Resilience       | System recovers quickly from failure |
| Fault Tolerance  | System continues to run despite failure |
| Redundancy       | Backup components to prevent single point of failure |
| Failover         | Automatic switch to backup component on failure |
| Durability       | Data preservation over time |
| Latency          | Time delay in data transfer |
| IOPS             | Input/Output Operations Per Second (storage speed) |
| Throughput       | Data transferred per unit time |
| Mutability       | System/component can be changed |
| Immutability     | Once created, cannot be changed (used in infra/containers) |
| DRY              | Don't Repeat Yourself (coding principle) |
| Idempotency      | Same result no matter how many times operation is repeated |
| Imperative       | Define **how** to do something (step-by-step) |
| Declarative      | Define **what** you want, not how (e.g., Terraform, YAML) |
| Backup & Restore | Creating copies for recovery in failure scenarios |
| Cost Optimization | Reducing unnecessary cloud spend while ensuring performance, availability, and scalability. Done using right-sizing, auto-scaling, reserved instances, S3 lifecycle rules, etc. |

