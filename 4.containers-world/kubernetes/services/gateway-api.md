## **What is missing in Ingress?**

Kubernetes Ingress has some limitations, which the **Gateway API** addresses:

1. **Limited protocol support**

   * Ingress is mostly HTTP/HTTPS only.
   * Cannot natively handle TCP, UDP, gRPC, or other protocols.

2. **Limited routing flexibility**

   * Only supports **basic host/path-based routing**.
   * Hard to do **advanced routing** (header-based, method-based, weighted traffic).

3. **Limited multi-tenancy & delegation**

   * Ingress resources are not great for **multi-team environments**.
   * Hard to delegate control over routing rules to different teams safely.

4. **Extensibility**

   * Ingress has a fixed spec → adding new features requires controller-specific annotations.

---

## **Why use Kubernetes Gateway?**

The **Gateway API** is designed to overcome Ingress limitations:

1. **Supports multiple protocols**

   * HTTP, HTTPS, TCP, UDP, gRPC, etc.

2. **Advanced routing**

   * Path-based, host-based, header-based, method-based, weighted routing.
   * Can handle **traffic splitting**, retries, and mirroring (controller dependent).

3. **Separation of responsibilities**

   * **Gateway resource** → defines entry points (load balancers, listeners).
   * **HTTPRoute / TCPRoute / UDPRoute** → define routing rules.
   * Enables **multi-team delegation** (one team manages Gateway, others manage Routes).

4. **Extensible and versioned**

   * Gateway API is evolving → new features can be added without breaking backward compatibility.

---

### **In short**

* **Ingress** → simple HTTP(S) routing, limited features, single resource type.
* **Gateway API** → protocol-agnostic, advanced routing, multi-team safe, extensible.

---
Here’s a clear breakdown of the **Kubernetes Gateway API components**:

---

## **1. Gateway**

* Defines the **entry point** to the cluster.
* Represents **load balancers, listeners, and ports**.
* Think of it as the equivalent of an **Ingress Controller**, but protocol-agnostic and more flexible.
* Examples: HTTP, HTTPS, TCP, UDP listeners.

**Key points:**

* Managed by the cluster administrator.
* Can host multiple routes (HTTPRoute, TCPRoute, etc.).

---

## **2. GatewayClass**

* Defines a **class of Gateways** (like a template).
* Specifies the **controller** responsible for implementing the Gateway.
* Example: `gateway.networking.k8s.io/aws` or `gateway.networking.k8s.io/nginx`.
* Allows **standardization** and ensures multiple teams can use consistent Gateway implementations.

---

## **3. Routes**

Routes define **how traffic should flow from a Gateway to services**. They are protocol-specific:

1. **HTTPRoute**

   * Routes HTTP/HTTPS traffic.
   * Supports host/path, headers, query parameters, and traffic splitting.

2. **TCPRoute**

   * Routes TCP traffic to backend services.

3. **UDPRoute**

   * Routes UDP traffic to backend services.

4. **TLSRoute** (optional / experimental in some implementations)

   * Routes TLS-encrypted traffic.

**Key points:**

* Routes are **bound to a Gateway**.
* Can reference multiple backend services.
* Supports advanced routing rules like weighted traffic or header-based routing.

---

## **4. BackendRef**

* Specifies **which Service (or other supported backend) will receive traffic** from a Route.
* Can include:

  * Service name
  * Port
  * Weight (for traffic splitting)

---

## **5. ServiceAccount / RBAC (Optional)**

* Optional but important for **multi-tenant environments**.
* Gateway API supports **delegating control**: one team can manage Gateways, another team manages Routes.

---

### **Summary Table**

| Component                   | Role                                          |
| --------------------------- | --------------------------------------------- |
| Gateway                     | Entry point, defines listeners/ports          |
| GatewayClass                | Template / controller that implements Gateway |
| HTTPRoute/TCPRoute/UDPRoute | Define routing rules from Gateway to backends |
| BackendRef                  | Specifies backend service(s) for a Route      |
| RBAC / ServiceAccount       | Optional, supports multi-team delegation      |

---

## **Example: HTTP Gateway API**

### 1. **GatewayClass**

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: GatewayClass
metadata:
  name: example-gwclass
spec:
  controller: example.io/gateway-controller
```

### 2. **Gateway**

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: my-gateway
  namespace: default
spec:
  gatewayClassName: example-gwclass
  listeners:
    - name: http
      protocol: HTTP
      port: 80
```

### 3. **HTTPRoute**

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: my-http-route
  namespace: default
spec:
  parentRefs:
    - name: my-gateway
  rules:
    - matches:
        - path:
            type: Prefix
            value: /web
      backendRefs:
        - name: myapp-svc
          port: 80
```

**Explanation:**

* **GatewayClass** → defines the controller.
* **Gateway** → defines a listener (port 80, HTTP).
* **HTTPRoute** → traffic matching `/web` goes to `myapp-svc:80`.

---

## **Imperative Commands**

### Create Deployment & Service

```bash
kubectl create deployment myapp --image=nginx
kubectl expose deployment myapp --port=80 --target-port=80 --name=myapp-svc
```

### Apply Gateway API resources

```bash
kubectl apply -f gatewayclass.yaml
kubectl apply -f gateway.yaml
kubectl apply -f httproute.yaml
```

### Check Gateway API resources

```bash
kubectl get gatewayclass
kubectl get gateway
kubectl get httproute
kubectl describe gateway my-gateway
kubectl describe httproute my-http-route
```

### Test routing

* If you have an ingress controller implementing Gateway API, get its IP:

```bash
kubectl get svc -n <controller-namespace>
```

* Then test with curl:

```bash
curl http://<gateway-ip>/web
```

---