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
