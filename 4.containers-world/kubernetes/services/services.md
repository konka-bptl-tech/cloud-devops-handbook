## Services in Kubernetes

### Challenges with Pod Communication

* **Pod IPs are ephemeral (short-lived):**

  * When a Pod restarts, its IP changes.
  * During **scale-out**, new Pod IPs are added.
  * During **scale-in**, Pod IPs are removed.
* No built-in **load balancing mechanism** with Pod IPs.
* Difficult to **access Pods from outside the cluster**.
* Hence, we **do not rely on Pod IPs** for communication.

---

### Kubernetes Services

Kubernetes introduced **Services**, which are **independent of Pod lifecycle**.

**Key Features:**

* Provide a **stable IP address** and a **DNS name**.
* Enable **service discovery** inside the cluster.
* Offer **load balancing** across multiple Pods.
* **EndpointSlice Controller**:

  * Maintains the list of Pod IPs.
  * Continuously reconciles available Pod IPs matching with labels & selectors.

**Use Cases:**

* Internal communication between Pods.
* External communication with users or other systems.

---

### ClusterIP

* Default Service type in Kubernetes
* Enables communication **within the cluster**
* Request flow:

  ```
  Request --> SvcIP:SvcPort --> PodIP:PodPort
  ```

---

### NodePort

* Exposes Service **outside the cluster** using a static port **(30000–32767)**
* When NodePort is created → **ClusterIP also created automatically**
* Request flow:

  ```
  Request --> NodeIP:NodePort --> SvcIP:SvcPort --> PodIP:PodPort
  ```
* **Used for:** Development & testing

**Challenges:**

1. Not secure → opens ports across all worker nodes
2. Not practical to tell clients to use Node IPs
3. In scalable environments, multiple nodes added/removed → IP management not feasible
4. Single point of failure if Pods run only on one node

---

### LoadBalancer

* Provides a **single Public IP/DNS** with automatic failover
* Request flow:

  ```
  Request --> LoadBalancerDNS --> NodeIP:NodePort --> SvcIP:SvcPort --> PodIP:PodPort
  ```

**Challenges:**

1. Each Service needs a separate LoadBalancer
2. No advanced routing (path/host-based)

---

### ExternalName

* Forwards internal requests to **external resources** using DNS name

---
Perfect 👍 here’s the clean list of **imperative commands** for creating a deployment + service and the **troubleshooting commands** for each type.

---

## **Imperative Commands**

### Create Deployment

```bash
kubectl create deployment myapp --image=nginx --replicas=2
```

### Create Services

* **ClusterIP (default)**

```bash
kubectl expose deployment myapp --port=80 --target-port=80 --name=myapp-clusterip --type=ClusterIP
```

* **NodePort**

```bash
kubectl expose deployment myapp --port=80 --target-port=80 --name=myapp-nodeport --type=NodePort
```

* **LoadBalancer**

```bash
kubectl expose deployment myapp --port=80 --target-port=80 --name=myapp-lb --type=LoadBalancer
```

* **ExternalName**

```bash
kubectl create service externalname myapp-external --external-name=example.com
```

---

## **Troubleshooting Commands**

### Common

* `kubectl get pods -o wide` → check Pod IPs & status
* `kubectl get svc` → check service type, ports, and IPs
* `kubectl describe svc <service-name>` → verify selectors, ports, endpoints
* `kubectl get endpoints <service-name>` → confirm Pods are mapped to Service
* `kubectl logs <pod-name>` → check container logs
* `kubectl exec -it <pod-name> -- curl http://<service-name>:<port>` → test service inside cluster

### NodePort Specific

* `kubectl get nodes -o wide` → get Node IP
* `curl http://<NodeIP>:<NodePort>` → test external access

### LoadBalancer Specific

* `kubectl get svc <service-name>` → check EXTERNAL-IP
* `curl http://<EXTERNAL-IP>:<PORT>` → test from outside

### ExternalName Specific

* `kubectl describe svc <service-name>` → confirm external DNS target
* `nslookup <service-name>.<namespace>.svc.cluster.local` → test DNS resolution inside cluster

---