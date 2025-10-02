### services

Challenges with pods fo communication to access

1. Pod IP's are ephemeral means they are short lived
   - When Pod was restarted IP has been changed
   - During Scale out new POds IP's are added Scale IN Pod Ip's are removed
   - There is no loadbalacing mechansim
   - To access outside the cluster
  This is were we not relay on POd IP's for communication

K8s introduces services which are indipendent from the Pod Lifecycle

Service Discovery
They gave stabele IP address & DNS name
They Do Loadbalacing
EndPointSliceController maintains the list of Pods IP's it will continuously reconcile avialable pod IP's matched with labels & selectors
Used for Internal & External Communication

ClusterIP:
---------
1. Default svc in k8s
2. Enables communication with in the cluster
request --> SvcIP:SvcPort --> PodIP:PodPort

NodePort:
---------
1. Exposes the service in outside cluaster with an static port[30000-32767]
2. When ever node port was created automatically cluster IP also created

request --> NodeIP:NodePort --> SvcIP:SvcPort --> PodIP:PodPort
used for development & testing

Challenges:
----------
1. Not Secure Opening Port on across worker nodes
2. It is not possible to go tell the client you can access my service
3. In scalable env multiple nodes are addeded/remove not feasible remember IP address
4. Single Point of failure If pod was running on only one worker node if pod goes down svc not return anything

LoadBalancer:
-------------
Provides a single Public IP with automatic failover so no manual intervention is needed if node goes down

request --> LoadBancerDNS --> NodeIP:NodePort --> SvcIP:SvcPort --> PodIP:PodPort

Chanllenges:
------------
1. To expose svc outside cluster we need seperate LB seperate svc
2. No advanced routing capabilities[path,host]

ExternalName:
------------
Forwards internal requests to outside resources using DNS name

### Why do we need ingress

1. NodePort svc is not Scalable[Dynamic Scaling environment we have cluster auto scaler/karpenter to launch instances opening static port on each node is not a good practice/impracticle]
- security wise opening port not a ideal node IP's are keeping changing nodes in private not accessible outside 
2. LoadBaalncer is
   - Costly per svc
   - Lacks HTTP awareness
   - TLS Termination
When you create svc as LoadBalancer it will create Layer4 load balancer it only understands transport layer it only deals with port numbers have no understanding about http or any other layer 7 protocol it just understands plaine layer 4 i.e is port numbers 

Actually we are running multiple application in single k8s cluster to access each service spinning seperate LB is not a cost effective solution

In https the traffic is encrypted end to end when the traffic reaches to app knows how to decrypt the  traffic  or LB has capability decrypting the traffic and that is called TLS termination LB has the capability to offload the TLS traffic 


upgrade,patch,maintenance autoamtion and innovation we nee to take we mintatain LB  
What we want?
- HTTP aware routing 
  path-based routing myapp.com/iphone,myapp.com/android
  host-based routing iphone.myapp.com,android.myapp.com
  TLS Termination
- Single LB serving multiple apps/microservices
- Declarative routing rules

Ingress is a k8s API object that defines HTTP(s) routing rules for extend traffic. It acts as a layer 7 router directing requests to internal services based on hostnames paths or other application-layer attributes

kubectl api-resources | grep -i ingress

IngressController running as a pod in the cluster it watches/monitor ingress resource/object it will creates the appropriate roting rules in ALB or ALB TG binding

- IC watches for IR &
- Creates an http(s) on cloud

IR = configuration of LoadBalancer


EKS Control Plane 
 Each Cluster has 
 - Atleast 2 API servers nodes
 - Atleast 3 etcd nodes
 AWS handles
 - auto healing of faulty control plane nodes
 - patching & upgrading
 - HA & Scalability
 - Security upgrades and certificate rotation

EKS data plane
- Consists of EC2 instances that run your workloads
- Nodes are grouped into Node Groups
  - Managed NG
  - Self-Managed NG
- Each Node group typically
  - TYpically uses same AMI & Instance Type

IR configuration
----------------
target-type: ip (Direct-to-pod routing via VPC CNI)

- k8s svc is used only to identify backend pods
- ALB forwards traffic directly to Pod IPs [fewerhops]
- Requires correct SG rules on node ENIs which are automatically handled by the AWS LBC during ALB provisioning


target-type: instance (NodePort based routing via kube-proxy)
- ALB routes to ec2 node port traffic goes through kube proxy
- Adds extra network hops and latency
- works without VPC CNI suitable for calico and weavenet


Ingress natively supports only HTTP(s) host and path based routing

advanced features come from controller specific annotations

Annotations vary by vendor and aren't valiadated by k8s

What is missing in ingress?
---------------------------

1. Native multi-tenancy or namespace level route isolation
2. Support for TCP,UDP orgRPC routing
3. First Class features like canary(traffic splitting or weighted routing) SSL redirect rewrites rate limiting
4. Portability annotations are vendor specific and not spec validated[if migrated one ingress to another IC you need to take care of vendor specific annotations]
5. RBAC is an still a concern

Ingress resources are namespaced scope If i have 10 applications need to expose 
RBAC is an if ingress is a namespaces each developer need to have an access all namespaces which are need to expose I want clear delineation between what actions can be performed by what all resources

gRPC is a opensource high performance protocol for remote procedure call 

Rewrite: CHanges the request URL internally before it reaches the backend(client does not see the change)
Example: /shop to /store/index.html

Redirect instructs the clients browser to make new request to different URL (visible to the user)
Example: /shop to https://myapp.com/store

rate limit user can send in minute these many requests only


# Gateway API

Gateway API = Next gen Ingress with multi-protocol support role seperation and portable traffic management

1. Native multi-tenancy or namepsace level route isolation
2. Support for TCP UDP or gRPC routing HTTP
3. First Class features like canary(traffic splitting or weighted routing ,SSL redirect,rewrites,rate limiting)
4. Not built in resource enabled via CRDs and requires a compatible controller to function
5. Developed and maintained by k8s SIG[Special interest group]

If you want something to be constantly checked wheather is working fine or not it requires controller desired should matched to current state

proper role seperatin & segregation 

Gateway Class[infra provider]
-------------
1. Logical template for Gateway configuration and features
2. Binds to specific Gateway COntroller implementation
3. Referenced by gateways does not create runtime resources
4. Holds provider specific parameters and default route
5. Typically managed by infra/platform team for consistency

Gateway[Cluster Operators] namespace scoped
--------------------------
1. provisions the laod balancer defined by its gateway class
2. configures listners ports,protocols,hostnames
3. links one or more backend services 
4. reference a single gateway class for controlling binding
5. typically provisioned/managed by cluster operators

Route Objects[Application developers] namespace scoped
-------------------------------------
1. Define routing rules for gateways
2. supports http,udp,tcp,grpc
3. forward traffic to backend k8s services
4. Managed by application developers or service owners



