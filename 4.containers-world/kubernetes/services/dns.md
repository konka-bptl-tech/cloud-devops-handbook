### **Why Kubernetes DNS?**

In Kubernetes, Pods are **ephemeral** and their IP addresses **change frequently** when they are restarted, rescheduled, or scaled.
If you try to connect to a Pod using its IP, the connection will break whenever the Pod is recreated.
To solve this, Kubernetes uses **DNS-based service discovery**.

---

### **What is Kubernetes DNS?**

**Kubernetes DNS** is a **built-in cluster DNS service** (usually implemented using **CoreDNS**) that provides **automatic DNS resolution** for Services and Pods inside the cluster.

* Every Service in Kubernetes gets a **DNS name**.
* Pods can communicate with each other using **service names** instead of IP addresses.
* DNS entries are automatically updated when Pods or Services change.

---

### ✅ **How it works**

* When you create a **Service**, Kubernetes assigns it a **stable IP (ClusterIP)** and also creates a **DNS record** for it.
* CoreDNS (or kube-dns) runs as a Deployment in the `kube-system` namespace and responds to DNS queries.
* Applications inside Pods can simply call `http://<service-name>` or `http://<service-name>.<namespace>.svc.cluster.local`.

---

### ✅ **DNS Naming Convention**

* **Service Name:** `myservice`
* **Namespace:** `mynamespace`
* **Cluster Domain:** `cluster.local` (default)
* Full DNS name:

  ```
  myservice.mynamespace.svc.cluster.local
  ```

---

### ✅ **Example**

#### Scenario:

* You have a Service named `backend` in namespace `dev`.
* DNS name will be:

  ```
  backend.dev.svc.cluster.local
  ```

#### How Pods use it:

```bash
curl http://backend.dev.svc.cluster.local
```

Or simply:

```bash
curl http://backend
```

(because Kubernetes DNS allows short names if both are in the same namespace).

---

### ✅ **Why DNS is important in Kubernetes**

* **Pod IPs are dynamic** – DNS provides stable names.
* **Service Discovery** – Applications can find each other by name.
* **Load Balancing** – DNS resolves to the Service IP, which load balances traffic across Pods.

---

### ✅ **kubectl Commands to Check DNS**

1. Check CoreDNS pods:

```bash
kubectl get pods -n kube-system -l k8s-app=kube-dns
```

2. Check CoreDNS Config:

```bash
kubectl -n kube-system describe configmap coredns
```

3. Test DNS inside a Pod:

```bash
kubectl run testpod --image=busybox:latest -it -- nslookup backend
```

---