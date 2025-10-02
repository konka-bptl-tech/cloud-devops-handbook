### **Check Ingress Resources**

* List all Ingress resources in all namespaces:

```bash
kubectl get ingress --all-namespaces
```

* List Ingress resources in a specific namespace:

```bash
kubectl get ingress -n <namespace>
```

* Describe an Ingress resource (shows rules, backend services, events):

```bash
kubectl describe ingress <ingress-name> -n <namespace>
```

---

### **Check Ingress Controller**

* Check Ingress controller Pods:

```bash
kubectl get pods -n <ingress-namespace>
```

* Check logs of Ingress controller Pod:

```bash
kubectl logs <ingress-controller-pod> -n <ingress-namespace>
```

* Describe Ingress controller Pod (check events, errors):

```bash
kubectl describe pod <ingress-controller-pod> -n <ingress-namespace>
```

---

### **Check Endpoints / Routing**

* Verify Services behind Ingress have endpoints:

```bash
kubectl get endpoints <service-name> -n <namespace>
```

* Test routing from inside cluster:

```bash
kubectl run curlpod --rm -it --image=busybox --restart=Never -- sh
# inside pod
curl http://<ingress-host-or-ip>/<path>
```

* Check Ingress API resource availability:

```bash
kubectl api-resources | grep -i ingress
```

---
