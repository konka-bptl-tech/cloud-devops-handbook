# Early Morning[6-9]
## Linux & Shell Scripting

## Ansible

# Morning[9:30-1:30]
## Docker
## Terraform
## Kubernetes
## Git
## Jenkins & GithubActions,ArgoCD
## Observability
   - Monitoring
   - Logging
   - Traces
   - SLA,SLO,SLI

# Afternoon[2:30-5:30]
## EKS Project
## ECS Project
## 3-tier Project


# Night[6:30-9:30]
## Interview Preparation
## Resume Preparation
## LinkedIN,Naukri,GithubProfile Grooming



┌─────────────────────────────────────────────────────────────┐
│                     Frontend (React)                         │
│  ├─ Patient Management  ├─ Appointment Scheduling           │
│  ├─ Doctor Dashboard    ├─ Medical Records                  │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                  Backend (Spring Boot)                       │
│  ├─ REST APIs          ├─ Redis Cache                       │
│  ├─ Security           ├─ Observability (Micrometer)        │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│              Data Layer (MySQL + Redis)                      │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Complete Project Structure
```
healthcare-system/
├── frontend/                          # React Application
│   ├── src/
│   │   ├── components/
│   │   │   ├── Patient/
│   │   │   │   ├── PatientList.jsx
│   │   │   │   ├── PatientForm.jsx
│   │   │   │   └── PatientList.test.jsx
│   │   │   ├── Doctor/
│   │   │   │   ├── DoctorList.jsx
│   │   │   │   ├── DoctorForm.jsx
│   │   │   │   └── DoctorList.test.jsx
│   │   │   ├── Appointment/
│   │   │   │   ├── AppointmentScheduler.jsx
│   │   │   │   ├── AppointmentList.jsx
│   │   │   │   └── AppointmentScheduler.test.jsx
│   │   │   └── Dashboard/
│   │   │       ├── Dashboard.jsx
│   │   │       └── Dashboard.test.jsx
│   │   ├── services/
│   │   │   ├── api.js
│   │   │   ├── patientService.js
│   │   │   ├── doctorService.js
│   │   │   ├── appointmentService.js
│   │   │   └── monitoring.js          # Frontend observability
│   │   ├── utils/
│   │   │   ├── logger.js
│   │   │   └── tracer.js
│   │   ├── App.jsx
│   │   ├── App.test.jsx
│   │   └── setupTests.js
│   ├── package.json
│   ├── jest.config.js
│   ├── .eslintrc.js
│   └── Dockerfile
│
├── backend/                           # Spring Boot Application
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/healthcare/
│   │   │   │   ├── HealthcareApplication.java
│   │   │   │   ├── config/
│   │   │   │   │   ├── RedisConfig.java
│   │   │   │   │   ├── SecurityConfig.java
│   │   │   │   │   ├── ObservabilityConfig.java
│   │   │   │   │   └── SwaggerConfig.java
│   │   │   │   ├── controller/
│   │   │   │   │   ├── PatientController.java
│   │   │   │   │   ├── DoctorController.java
│   │   │   │   │   ├── AppointmentController.java
│   │   │   │   │   └── MetricsController.java
│   │   │   │   ├── service/
│   │   │   │   │   ├── PatientService.java
│   │   │   │   │   ├── DoctorService.java
│   │   │   │   │   ├── AppointmentService.java
│   │   │   │   │   └── CacheService.java
│   │   │   │   ├── repository/
│   │   │   │   │   ├── PatientRepository.java
│   │   │   │   │   ├── DoctorRepository.java
│   │   │   │   │   └── AppointmentRepository.java
│   │   │   │   ├── model/
│   │   │   │   │   ├── Patient.java
│   │   │   │   │   ├── Doctor.java
│   │   │   │   │   └── Appointment.java
│   │   │   │   ├── dto/
│   │   │   │   │   ├── PatientDTO.java
│   │   │   │   │   ├── DoctorDTO.java
│   │   │   │   │   └── AppointmentDTO.java
│   │   │   │   ├── exception/
│   │   │   │   │   ├── GlobalExceptionHandler.java
│   │   │   │   │   └── ResourceNotFoundException.java
│   │   │   │   ├── aspect/
│   │   │   │   │   ├── LoggingAspect.java
│   │   │   │   │   └── MetricsAspect.java
│   │   │   │   └── filter/
│   │   │   │       └── TracingFilter.java
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       ├── application-dev.yml
│   │   │       ├── application-prod.yml
│   │   │       └── logback-spring.xml
│   │   └── test/
│   │       └── java/com/healthcare/
│   │           ├── controller/
│   │           │   ├── PatientControllerTest.java
│   │           │   ├── DoctorControllerTest.java
│   │           │   └── AppointmentControllerTest.java
│   │           ├── service/
│   │           │   ├── PatientServiceTest.java
│   │           │   ├── DoctorServiceTest.java
│   │           │   └── AppointmentServiceTest.java
│   │           └── integration/
│   │               └── HealthcareIntegrationTest.java
│   ├── pom.xml
│   ├── Dockerfile
│   └── load-test/
│       └── k6-load-test.js           # Load testing script
│
├── infrastructure/                    # Observability Stack
│   ├── docker-compose.yml            # All services
│   ├── prometheus/
│   │   └── prometheus.yml            # Prometheus config
│   ├── grafana/
│   │   ├── dashboards/
│   │   │   ├── application-dashboard.json
│   │   │   ├── jvm-dashboard.json
│   │   │   └── redis-dashboard.json
│   │   └── provisioning/
│   │       ├── dashboards.yml
│   │       └── datasources.yml
│   ├── loki/
│   │   └── loki-config.yml           # Log aggregation
│   ├── tempo/
│   │   └── tempo-config.yml          # Distributed tracing
│   └── jaeger/
│       └── jaeger-config.yml         # Alternative tracer
│
├── ci-cd/                            # CI/CD Pipelines
│   ├── .github/
│   │   └── workflows/
│   │       ├── backend-ci.yml
│   │       ├── frontend-ci.yml
│   │       ├── integration-tests.yml
│   │       └── deploy.yml
│   ├── .gitlab-ci.yml
│   └── jenkins/
│       └── Jenkinsfile
│
├── k8s/                              # Kubernetes manifests (Optional)
│   ├── namespace.yaml
│   ├── frontend-deployment.yaml
│   ├── backend-deployment.yaml
│   ├── mysql-statefulset.yaml
│   ├── redis-deployment.yaml
│   └── ingress.yaml
│
├── scripts/
│   ├── setup.sh                      # Initial setup
│   ├── start-services.sh             # Start all services
│   ├── run-tests.sh                  # Run all tests
│   └── load-test.sh                  # Run load tests
│
├── docs/
│   ├── API.md                        # API Documentation
│   ├── ARCHITECTURE.md               # Architecture details
│   ├── OBSERVABILITY.md              # Observability guide
│   └── INTERVIEW_GUIDE.md            # Interview talking points
│
├── postman/
│   └── Healthcare-API.postman_collection.json
│
└── README.md







1. Communication Skills
2. Resume Preparation
3. Github Profile
4. Naukri Profile
5. LinkedIn Profile
6. Interview Preparation
   - Tell me about yourself
   - Explain about your peoject
   - What is the biggest task that your faced recently
   - Why do we hire you
   - Why do you change your last job
   - 
7. Projects
   - 3-tier project on EC2
   - 3-tier porject on Serverless
   - 3-tier,Instana on EKS
     3-projects has 
     Terraform for IaC
     Monitoring & Logging
8. TroubleShooting Skills


# Networking Concepts

# Basic Concepts

# Linux & Bash Scripting

# Ansible

# AWS

# Terraform

# Docker

# Kubernetes

# Jenkins & Github Actions 

# Prometheus & Grafana

# ELK Stack

# ISTIO,Karpenter,ArGoCD,HELM,Kustomization,Kyverno

# DevOps Cloud
![DevOps Flow](./images/flow.drawio.svg)

# Projects Sessions
- infrasetup
- ci/cd pipelines
- monitoring & logging
- release management
- project explanation practice
### 

### 3-tier[9:30AM to 11:30AM]

### Serversless[12PM to 2PM]

### EKS[3PM to 5PM]

### Resume Session & Profiles Building