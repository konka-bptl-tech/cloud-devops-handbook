| Category | AWS Service | Azure Service | GCP Service | 1-line Explanation |
|---|---|---|---|---|
| Compute (VMs) | EC2 (Elastic Compute Cloud) | Virtual Machines | Compute Engine | General-purpose virtual machines for running OS and workloads. |
| Compute - VM Disks | EBS (Elastic Block Store) | Managed Disks | Persistent Disk | Block-level persistent storage for VMs. |
| Compute - PaaS App Hosting | Elastic Beanstalk | App Service | App Engine / Cloud Run | Platform-managed app hosting (deploy code, platform handles infra). |
| Auto Scaling | Auto Scaling Groups (ASG) | VM Scale Sets | Instance Groups + Autoscaler | Horizontal scaling of VM fleets based on policies/metrics. |
| Serverless - Functions | Lambda | Azure Functions | Cloud Functions | Event-driven FaaS for short-lived serverless functions. |
| Serverless - Containers | Fargate (with ECS/EKS) | Azure Container Instances (ACI) | Cloud Run | Run containers serverless without managing nodes. |
| Containers - Orchestration | ECS / EKS (Kubernetes) | AKS (Kubernetes) | GKE (Kubernetes) | Managed Kubernetes and container orchestration services. |
| Containers - Registry | ECR (Elastic Container Registry) | Azure Container Registry (ACR) | Artifact Registry / Container Registry | Store and manage container images. |
| Networking - VPC | VPC (Virtual Private Cloud) | Virtual Network (VNet) | VPC (Virtual Private Cloud) | Isolated virtual network for cloud resources. |
| Networking - DNS | Route 53 | Azure DNS | Cloud DNS | Managed DNS zones and record management. |
| Networking - Load Balancing | ELB (ALB / NLB / CLB) | Azure Load Balancer & Application Gateway | Cloud Load Balancing | Distribute traffic (L4 & L7) across backends. |
| Networking - CDN | CloudFront | Azure CDN | Cloud CDN | Global content delivery network for caching & edge delivery. |
| Networking - NAT / Gateway | NAT Gateway, Internet Gateway | NAT Gateway, Public IP / Gateway | Cloud NAT, Cloud Router | Managed NAT and routing for outbound/inbound connectivity. |
| Networking - Private Link/Peering | VPC Peering, PrivateLink | VNet Peering, Private Link | VPC Peering, Private Service Connect | Private connectivity between networks/services. |
| Storage - Object | S3 (Simple Storage Service) | Blob Storage | Cloud Storage (GCS) | Highly durable object storage for files/blobs. |
| Storage - File | EFS (Elastic File System) | Azure Files | Filestore | Managed network file systems (NFS/SMB) for shared mounts. |
| Storage - Archive | Glacier / S3 Glacier | Blob Archive | Nearline / Coldline / Archive | Low-cost long-term archive storage tiers. |
| Databases - Managed SQL | RDS (MySQL/Postgres/SQL Server) | Azure Database for MySQL/Postgres/SQL DB | Cloud SQL | Managed relational databases with automated ops. |
| Databases - Distributed RDBMS | Amazon Aurora | Azure SQL (Managed Instances / Hyperscale) | AlloyDB / Cloud Spanner (for scale) | High-performance managed relational databases with extras. |
| Databases - NoSQL (KV/Doc) | DynamoDB | Cosmos DB | Firestore / Datastore / Bigtable | Managed NoSQL databases for key-value/document/wide-column. |
| Databases - Wide-column / OLAP | Redshift | Azure Synapse Analytics | BigQuery | Data warehouse / analytics services for big data queries. |
| Caching | ElastiCache (Redis / Memcached) | Azure Cache for Redis | Memorystore (Redis) | Managed in-memory caches for fast reads. |
| Messaging - Queue | SQS (Simple Queue Service) | Azure Queue Storage / Service Bus Queues | Pub/Sub (can be queue-like) / Cloud Tasks | Reliable queueing for asynchronous tasks. |
| Messaging - Pub/Sub | SNS (Simple Notification Service) | Event Grid / Service Bus Topics | Pub/Sub | Pub/sub messaging for fan-out, events and notifications. |
| Streaming / Eventing | Kinesis | Event Hubs | Pub/Sub + Dataflow | Real-time streaming ingestion & processing services. |
| IAM & Identity | IAM (Users, Roles, Policies) | Azure AD + RBAC | Cloud IAM | Identity, authentication and authorization controls. |
| Secrets & Keys | Secrets Manager / Parameter Store, KMS | Key Vault, Azure Managed HSM | Secret Manager, Cloud KMS | Secrets, encryption keys, and key management services. |
| Security - Threat Detection | GuardDuty, Security Hub | Azure Defender / Sentinel | Security Command Center | Threat detection and security posture monitoring. |
| Encryption (managed KMS) | KMS (Key Management Service) | Key Vault / Managed HSM | Cloud KMS | Customer-managed and managed keys for encryption. |
| Monitoring & Logging | CloudWatch, CloudTrail | Azure Monitor, Azure Log Analytics | Cloud Monitoring & Cloud Logging (formerly Stackdriver) | Metrics, logs, tracing, and audit trails. |
| Tracing / APM | X-Ray | Application Insights | Cloud Trace / Profiler | Distributed tracing and application performance monitoring. |
| CI/CD - Source & Pipelines | CodeCommit, CodeBuild, CodeDeploy, CodePipeline | Azure DevOps (Repos, Pipelines) | Cloud Source Repositories, Cloud Build, Cloud Deploy | End-to-end CI/CD toolchains and hosted repos/build. |
| Infrastructure as Code | CloudFormation | ARM Templates / Bicep | Deployment Manager / Config Connector | Declarative infra templates for provisioning resources. |
| Secrets for Infra | Systems Manager Parameter Store | Azure App Configuration / Key Vault | Secret Manager / Runtime config | Store config & secrets for apps and infra. |
| Observability - Dashboards | CloudWatch Dashboards | Azure Dashboards | Cloud Monitoring Dashboards | Build visual dashboards for metrics and alerts. |
| Backup & DR | AWS Backup | Azure Backup | Backup for GCP (various solutions) | Centralized backup and recovery solutions. |
| Data Migration | DMS (Database Migration Service) | Database Migration Service | Database Migration Service | Services to migrate databases and data to cloud. |
| Analytics / ETL | Glue | Data Factory | Dataflow / Data Fusion | ETL / data integration and orchestration services. |
| Big Data / Hadoop | EMR (Elastic MapReduce) | HDInsight | Dataproc | Managed Hadoop/Spark clusters for big data processing. |
| ML Platform | SageMaker | Azure ML | Vertex AI | Managed platforms for training, deploying ML models. |
| IAM Federation / SSO | AWS SSO, Cognito | Azure AD (SSO, B2C) | Identity Platform, Cloud Identity | User authentication, federation, and customer identity. |
| Mobile Backend | Amplify | Mobile Apps / App Center | Firebase | Mobile-focused backend and developer tools. |
| IoT | IoT Core / IoT Greengrass | IoT Hub | IoT Core | Device-to-cloud connectivity and IoT services. |
| Edge / Hybrid | Outposts, Wavelength | Azure Stack / Azure Arc | Anthos, Distributed Cloud | Hybrid / on-prem & edge managed offerings. |
| Service Mesh | App Mesh | Azure Service Mesh (Open Service Mesh support) | Anthos Service Mesh (Istio) | Managed service mesh implementations. |
| Site-to-Site VPN | AWS VPN / Direct Connect | VPN Gateway / ExpressRoute | Cloud VPN / Dedicated Interconnect | Private, dedicated, or VPN connectivity options. |
| Workflow / Orchestration | Step Functions | Logic Apps / Durable Functions | Workflows / Cloud Composer (Airflow) | Orchestrate serverless workflows and long-running processes. |
| Notifications / Email | SNS, SES (Simple Email Service) | Notification Hubs, Communication Services | Pub/Sub + SendGrid partner / third-party | Delivery of notifications and email services. |
| Governance / Policy | AWS Organizations, SCPs | Azure Policy, Management Groups | Resource Manager + Organization policies | Tenant-level governance and policy enforcement. |
| Cost Management | AWS Cost Explorer, Budgets | Azure Cost Management | Cloud Billing Reports, Cost Management | Cost analytics, budgeting and forecasting tools. |
| Marketplace / 3rd-party | AWS Marketplace | Azure Marketplace | Google Cloud Marketplace | Curated third-party software and marketplace services. |
| Serverless & API | Lambda | Azure Functions | Cloud Functions | Event-driven FaaS for running short-lived serverless functions. |
| Serverless & API | API Gateway | Azure API Management | API Gateway / Cloud Endpoints | Managed service to create, deploy, secure, and monitor APIs. |
