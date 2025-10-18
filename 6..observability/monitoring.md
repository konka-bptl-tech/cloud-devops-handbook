Data Points = Health of the system
Such as CPU,Memory,Network I/O, Disk I/O ..........

Prometheus is a TSDB it will keeps hisotrical data of a system
at some time how CPU utilization Memory Utilization

Monitoring system collect the metrics scarape the metrics which represents in dashboard format
- scrape the metrics
- represents the metrics in dashboard format
- fire or notify alerts when cpu,memory reaches 80 % of utilization

- How many times a pod went to crashloopbackoff in day
- Deployment status

Grafana has strong visualization capability and Rich Set of DashBoards
- You can integrated with you IAM 



----------- Exporters
- NodeExporter
- NginxExporter
- Kubestatemetrics Exporter
- Mysql Exporter
- /metrics to get
- Application level metrics
  - How many HTTP Requests 

Prometheus is a CNCF project


- NodeExporter gives infra level metrics to the Prometheus
- Kubestatemetrics get lot of in fo from k8s cluster
- custom metrics scrpate metrics related to application 
  - how many requests

curl 10.100.215.221:8080/metrics | grep container | grep restart

kube_pod_container_status_restarts_total{}
kube_pod_container_status_restarts_total{namespace="default"}

kubectl run busybox-crash --image=busybox -- /bin/sh -c "exit 1"


custom metrics
- Gauge = nature of metric increment as well as decrement
- Counter = nature of metric is always increment use counter
- Summary = 
- Histogram = no need to worry about increment/decrement just need bucket of info go for Histogram
  - What is the http latency
  - What is the http request duration
  - Tell me how many times http request takes less than 5ms
  - How many time http request takes more than 100ms
  - How many time cpu utilization went below 50%
  - Create buckets for 5ms 10 ms .............. so this way we record information in buckets
  these type of metrics should be recorded in the buckets 
instrumentation = writing scrape endpoint and writing loggers and definning tracing is called instrumentation

/login 
/metrics 



I have reactjs application hosted in nginx how can i get metrics from nginx like gauge,counter,Histogram
- http request latency
- http request takes 5ms to response 10ms 20ms

How can i instrument my spring boot java application 
http request total - counter
http request duration seconds - histogram[0.1,0.2,05,1]
http request duration summary secords






# Tasks
1. alerts configuration for different incidents
   - disk usage reaches 80%
   - system down
   - app down
   - cpu & memory consumption reaches to 60%
2. Simple grafana dashboards creation
3. Metrics Scraping best practices
4. Recording rules
5. Grafana templating & Multi-Service Dashboards

---

### ✅ 1. **Infrastructure / System-Level Metrics**

These are the health of the underlying compute (Server, EC2, ECS, Kubernetes Pod, etc.)

* **CPU usage** (high CPU = performance bottleneck)
* **Memory usage** (increase over time = memory leak)
* **Disk I/O / Storage usage**
* **Network traffic (in/out bytes, latency)**
* **Pod restarts / container health** (for Kubernetes)
* **Node health (Ready / NotReady in Kubernetes)**

---

### ✅ 2. **Application Performance Metrics**

These define the experience of end users

* **Response time (latency — P50, P90, P99)**
* **Request throughput (RPS – requests per second)**
* **Error rate (% of failed API calls — 4xx/5xx)**
* **DB query execution time**
* **External call latency (e.g., payment API, auth service)**
* **Queue processing delay (SQS, Kafka, RabbitMQ, etc.)**

---

### ✅ 3. **Business / Functional Metrics**

These are application-specific (decided by business)

* **Number of user signups**
* **Number of orders placed**
* **Failed payment count**
* **Active logged-in users**
* **Abandoned checkout count**
* **Revenue per minute / sales per region**

---

### ✅ 4. **Security & Reliability Metrics**

To ensure the app is protected

* **Login failures / brute-force attempts**
* **Unusual API access patterns / rate limit hits**
* **SSL certificate expiration**
* **IAM permission failures**
* **Number of 403/401 unauthorized requests**
* **API throttling or WAF blocked requests**

---

### Summary Table

| Category    | Example Metrics                            |
| ----------- | ------------------------------------------ |
| Infra       | CPU, Memory, Disk, Network, Pod Restarts   |
| Application | Latency, RPS, Error %, DB query time       |
| Business    | Orders, Signups, Revenue, Payment failures |
| Security    | Login failures, 401/403, WAF blocks        |

---
