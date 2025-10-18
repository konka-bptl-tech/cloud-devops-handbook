logs are messages written by developer to understand what the application doing at particular time loggers are help us debug the 
application

FlunetBit = Light weight Log collector[forwarder] , it is a vendor neutral
LogStash = It is a data formatter
           - logs aggregator
           - advance log filtering
        
ElasticSearch = It will stores the log data
Kibana = UI tool for Elastic Search
LogStash = filtering,format the logs before stroing the elastic search
filebeat = light weight log shipper



# ElasticSearch

# LogStash

# Filebeat

# Kibana


# Tasks

1. I need to collect the logs of only particular ns
2. I want format and parse the logs
3. Need to create dashboards for no of hists to the component how many are success and failure
4. I need to create dashboard for each component to look into logs of component




In **Kibana**, you mainly create dashboards using **application logs + infrastructure logs + security logs**. You can slice and visualize logs in powerful ways — not just raw text.

Here are the **main types of log dashboards** you can create:

---

### ✅ 1. **Application/API Monitoring Dashboard**

**Best for Devs & SRE team**

* Total Requests received (API hit count)
* Success vs Failure ratio
* Top API endpoints with error count (404 / 500 / 403)
* Average response time per endpoint
* User-Agent based request breakdown (iOS / Android / Web)

---

### ✅ 2. **Error & Exception Monitoring Dashboard**

**Best for debugging issues**

* Error logs grouped by **exception type**
* Top 5 most frequent errors
* Which service/pod is producing the most errors
* Stack trace with exact timestamp
* Error trend over time (Spike detection)

---

### ✅ 3. **User Journey Tracking (Business Dashboard)**

**For Product + Business Teams**

* How many users signed up
* Successful vs failed login attempts
* Order placed, payment success/failure trend
* Funnel visualization — at which stage users are dropping
* Geo-based logins (country/region-wise logins)

---

### ✅ 4. **Performance Debug Dashboard**

**Latency & performance issues**

* High response time API calls
* Slow queries detected from logs
* Requests per minute & peak time analysis
* Pod/Server specific performance logs
* GCP/AWS/Lambda cold start detection

---

### ✅ 5. **Security / Audit Dashboard**

**Best for Security Team & Compliance**

* 401 / 403 unauthorized access logs
* Multiple login failure attempts
* IPs hitting rate limits / DDOS behavior
* Which user accessed critical endpoints
* Suspicious Geo activity (e.g., logins from Russia at midnight)

---

### ✅ 6. **CI/CD & Deployment Observability**

**For DevOps Engineers**

* Logs showing deployment status
* Pod startup & crash logs
* Rollback detection (if deployment failed)
* Version-wise traffic split logs
* Canary release behavior monitoring

---

### ✅ Summary (Based on Teams)

| Dashboard Type       | Best For                |
| -------------------- | ----------------------- |
| API & Error Logs     | Developers              |
| User/Business Logs   | Product / Business Team |
| Security/Audit       | Security Team           |
| Latency & Debug Logs | SRE/Performance         |
| CI/CD Deploy Logs    | DevOps                  |

---

Do you want me to **create a sample Kibana dashboard structure** (field names, filters, visuals) exactly like it’s done in real production companies?
👉 **Yes — show me example**
👉 **No — go deeper into log types first**
