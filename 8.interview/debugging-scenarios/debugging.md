# Your stateful Kubernetes services just broke after an upgrade!

As a DevOps engineer, I’ve seen this nightmare scenario destroy weekends in production. 

When StatefulSets fail post-upgrade, every minute of downtime costs money.

Here’s my 7-step Kubernetes debugging playbook:

👉 Step 1: Verify the obvious
🔺 `kubectl get pods -n namespace` → Are pods actually running?
🔺 `kubectl get statefulsets -n namespace` → Check replica counts
🔺 `kubectl describe pod pod-name` → Look for crash loops or image pull errors

👉 Step 2: Hunt through Kubernetes events
🔺 `kubectl get events --sort-by=.metadata.creationTimestamp` → Recent cluster events
🔺 `kubectl describe statefulset statefulset-name` → Deployment-specific issues

👉 Step 3: Check persistent volume issues
🔺 `kubectl get pv,pvc -n namespace` → Volume binding problems
🔺 `kubectl describe pvc pvc-name` → Storage provisioning failures
🔺 `kubectl get storageclass` → Storage class compatibility after upgrade

👉 Step 4: Investigate resource consumption
🔺 `kubectl top pods -n namespace` → Memory/CPU limit breaches
🔺 `kubectl describe node node-name` → Node resource exhaustion
🔺 `kubectl get events | grep -i "failed.*schedule"` → Pod scheduling failures

👉 Step 5: Find networking and service issues
🔺 `kubectl get svc,endpoints -n namespace` → Service connectivity
🔺 `kubectl describe service service-name` → Load balancer problems
🔺 `kubectl get networkpolicies` → Network policy blocking traffic

👉 Step 6: Track configuration and secrets
🔺 `kubectl get configmap,secret -n namespace` → Missing configurations
🔺 `kubectl describe pod pod-name | grep -i "mount"` → Volume mount failures
🔺 `kubectl get pod pod-name -o yaml` → Compare with previous working config

👉 Step 7: Real-time debugging
🔺 `kubectl logs -f pod-name --previous` → Previous container crash logs
🔺 `kubectl exec -it pod-name -- /bin/bash` → Live container inspection
🔺 `kubectl port-forward pod-name 8080:8080` → Direct pod connectivity testing

# If you want to become good at Kubernetes troubleshooting, then learn these use cases:

1) How To Fix Kubernetes Node Not Ready 
↳ https://lnkd.in/gksPqZYF

2) How to Fix Kubernetes Node Disk Pressure 
↳ https://lnkd.in/gu9eFiRw

3) Understanding Kubernetes CreateContainerError 
↳ https://lnkd.in/gG_2nHb7

4) Understanding Kubernetes CreateContainerConfigError 
↳ https://lnkd.in/g6Z5TdBt

5) Kubernetes ImagePullBackOff Explained 
↳ https://lnkd.in/gzCTSWRG

6) Kubernetes RunContainerError Explained 
↳ https://lnkd.in/ggQcqi5t

7) How To Fix OOMKilled 
↳ https://lnkd.in/gznwimNr
