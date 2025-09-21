# Kubernetes Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. What is Container Orchestration
- [ ] Understand the need for container orchestration
- [ ] Compare manual container management vs orchestration
- [ ] Use cases in production environments

## 2. What is Kubernetes & What it Does
- [ ] Introduction to Kubernetes
- [ ] Benefits of Kubernetes
- [ ] Use cases in DevOps and microservices

## 3. Kubernetes Architecture & Components & General Request Flow
- [ ] Master and Worker nodes
- [ ] API Server, Scheduler, Controller Manager, etcd
- [ ] Kubelet, Kube-proxy
- [ ] Container Runtime Interface (CRI)
- [ ] Request flow from user → API → Scheduler → Kubelet → Pod

## 4. Pods & Pod Life Cycle & CRI
- [ ] What is a Pod
- [ ] Pod Life Cycle (Pending, Running, Succeeded, Failed, Unknown)
- [ ] Pod phases vs Pod conditions
- [ ] Container Runtime Interface (CRI)

## 5. Labels, Selectors & Annotations
- [ ] Labels (key-value pairs)
- [ ] Selectors (how controllers select Pods)
- [ ] Annotations (metadata)

## 6. Namespaces & Use Cases
- [ ] What are namespaces
- [ ] Using namespaces for isolation
- [ ] Multi-tenant use cases

## 7. Controllers
- [ ] ReplicaSet & Replication Controller
- [ ] Deployment
- [ ] StatefulSet
- [ ] DaemonSet
- [ ] Job & CronJob
- [ ] Horizontal Pod Autoscaler (HPA) & Metrics Server

## 8. Services & CNI
- [ ] ClusterIP
- [ ] NodePort
- [ ] LoadBalancer
- [ ] Headless Service
- [ ] ExternalName
- [ ] How DNS works in Kubernetes

## 9. Ingress & API Gateway
- [ ] Introduction to Ingress
- [ ] Ingress controllers
- [ ] API Gateway basics
- [ ] Routing rules

## 10. Volume Management & CSI
- [ ] Static Volume Management
- [ ] Dynamic Volume Management
- [ ] Persistent Volumes (PV) & Persistent Volume Claims (PVC)
- [ ] Storage Classes

## 11. Configuration Management
- [ ] ConfigMap
- [ ] Secrets
- [ ] Probes (Liveness, Readiness, Startup)

## 12. Scheduling
- [ ] Default Scheduling
- [ ] Advanced Scheduling
  - [ ] NodeSelector
  - [ ] Affinity, Pod Affinity & Anti-Affinity
  - [ ] Taints & Tolerations

## 13. Resource Management
- [ ] Requests & Limits
- [ ] Resource Quotas
- [ ] Limit Ranges

## 14. RBAC & Security
- [ ] Role & RoleBinding
- [ ] ClusterRole & ClusterRoleBinding
- [ ] Service Account
- [ ] Admission Controllers
- [ ] Network Policies
- [ ] Pod Security

## 15. CRDs & Operators
- [ ] Custom Resource Definitions (CRDs)
- [ ] Operators & use cases

## 16. Pod Priority, PriorityClass & Preemption
- [ ] Understanding pod priority
- [ ] PriorityClass definition
- [ ] Preemption mechanism

## 17. Kustomize & Helm
- [ ] Introduction to Kustomize
- [ ] Helm charts
- [ ] Managing environments & releases

## 18. Karpenter & Components
- [ ] What is Karpenter
- [ ] Dynamic cluster scaling
- [ ] Karpenter components

## 19. Istio & Components
- [ ] Introduction to Istio
- [ ] Service Mesh concepts
- [ ] Istio architecture & components
- [ ] Traffic management, security, observability
