1. Service mesh help to dealing with svc-to-svc communication
2. svc to svc communication happens over the http[non-secure] way

Network Policy has a limitation it is only dealing with TCP layer of communication layer3[Network][IPaddresses] and 
layer4[Transport][Ports] and k8s layers like so on so ns with so and so labels can communicate with so and so svc we can do that 

istio help us to restrict communication at method level more granular control for example one component need to communicate another component in only GET method we can able to do it with istio why do you make a unnecessary calls b/w components

allowing to making certain calls

principle of least privilege by using ingress and egress rules



sevice mesh = dedicated infrastructure layer it adds
- security
- obeservability
- traffic management
without changing application code 

istio injecting sidecar along with main container in the pod it will intercepting all traffic enter and exiting 
in to pod 

istio is one of the service mesh tool

It has 2 components

1. Control plane 
2. Data plane

pod = app container + side car istio proxy container

data plane maintains all the proxies deployed along with pod
control plane reads the configuration apply the configuration to the data plane proxies

Traffic Management 
------------------
1. controlling network traffic flows within a service mesh
2. configuring sidecar injection
3. using gateway resource to configure ingress and egress traffic
4. understanding how to use service entry resources for adding entries to internal service registry
5. define traffic policies using destination rule
6. configure traffic mirroring capabilites

https://github.com/solo-io/mesh-week


# What are the challenges we have without servicemesh

# What is ServiceMesh

# What is istio

# Istio Architecture

# Istio Features








# Running notes
service mesh help us manage communication between services in cluster

Network policy dealing with TCP layer of communication like if you say you cannot connect these IP's it won't and certain ports
Network policys are deals with network layers[ports,ipaddresses] and k8s layers[labels,selectors]
Network Policies
----------------
1. TCP layer[Ipaddresses&ports]
2. Kubernetes layer[namespaces][so and so labels can not communicate so and so labels of pods in particular ns]

challenges
----------
1. we would not know anything about how the communication b/w services of different components
2. If we big application where went wrong we would not know where what happend
3. Restrict unnecessary calls between components
4. communication between services happens plain communication happen istio takes encryption and decrytpion by default

1. Service mesh help to dealing with svc-to-svc communication
2. svc to svc communication happens over the http[non-secure] way

Network Policy has a limitation it is only dealing with TCP layer of communication layer3[Network][IPaddresses] and 
layer4[Transport][Ports] and k8s layers like so on so ns with so and so labels can communicate with so and so svc we can do that 

istio help us to restrict communication at method level more granular control for example one component need to communicate another component in only GET method we can able to do it with istio why do you make a unnecessary calls b/w components

allowing to making certain calls



1. Istio help us to enable or restrict method level access like http methods[API Calls]
2. enable secure communication between service components

amazon sg and nacl acts as layer 3 firewall

for example one component comprobmised so that they can do anything they want so we just allow API calls need for that conponents


allowing to making certin calls

find . | xargs du -sh


authorization policy









1. service meash ensure
- secure communication b/w 2 services
- ensure no data loss
- keeps track what happend b/w services[complete observability]

envoy proxy is a high performance open source proxy used by istio as its side car
acts as a traffic controller for the application
- routing traffic through the best path to deliver messages
- It encrypts the traffic b/w services ensures secure communication between 2 services
- Gives complete Observability
  - tracks traffic volume to each application
  - measures response times
  - detect application issues


- It ensures smooth app communication without complex network issues
- It ensures that all the data being transffered between service is encrypted and secure
- It helps track the health an performance of the applications 


- Reliability: It keeps apps running by redirecting traffic if a service fails route healthy services
- It provides features like
  rate limiting: 
  circuit braking:
  compression:
  traffic mirroring: 

istio is an orchestrator facilitates the managment of envoy proxies

has 2 components
1. control plane
resonsible for managing and configuring the data plane it handle distribution network policies certificate authority authentication authorization dynamically updating the configurations all the proxy side cars all of these handles of istiod
- service discovery
- govern traffic b/w services 
- istio also acts as certificate authority and generates and generates certificates allow tls communication b/w services 
- ensures end user authentication built in identity and credential management istio authorization feature to control to acts as who as access the service  
2. data plane 
responsible for controlling and managing traffic between microservices deploy side car proxies along side each workload to handle routing loadbalncing encryption using mTLS and security authentication 



# Traffic Management
It allows traffic routing to be customized based on various criteria
- traffic splitting
- canary releases
- mirrioring
- acts as loadbalancer 
1. controlling traffic flows within a service mesh
2. Configuring side car injection
3. Using gateway resource to configure ingress and egress traffic
4. Understanding how to use ServiceEntry resources for adding entries to internal service entry
5. Define traffic policies using destionation rules
6. Configuring traffic mirroring capabilties

# Securty
It automatically encrypts traffic between workloads using mTLS

# Policies[Authentication]
It enforces access control allowing only authorized service traffic

# Observability
It centralizes logs for easier aggregation and analysis we can use jaegar data dog APM to trace debugging and optimize microservices

# Resiliance and Reliability
It enables resiliance with circuit breaking, timeouts and retries to prevent cacading failures 

# Reduce Operation Overhead
It automates proxy management,ecryption,logging and traffic routing 


istio profile core componentns 

istioctl install --set profile=demo -y

kubectl label namsespace default istio-injectio=enabled

kubectl get ns default show-labels

istioctl profile list

# Tasks to achieve
- proemtheus and grafana installed on eks with custom domain as mine
  prometheus.konkas.tech
  grafana.konkas.tech

- ELK stack in ekscluster
- filebeat install on EKS cluster
  elastic.konkas.tech
  kibana.konkas.tech

- ArGoCD with custom domain
  argo.konkas.tech









# What is ServiceMesh

# What Problems can addresse by service mesh

# What is istio

# istio architecture and components
1. control plane
2. data plane
# Features of istio

# Ambient mesh