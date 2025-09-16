# ✅ Controlling Services and Daemons Cheat Sheet

---

## **1. What are Services and Daemons?**

* **Service**: A background process that runs continuously and provides a function (e.g., web server, database).
* **Daemon**: A specific type of service that runs in the background without direct user interaction (e.g., `sshd`, `httpd`).

**On modern Linux (RHEL, Ubuntu)** → Services and daemons are managed by **`systemd`**.

---

## **2. Important Directories & Files**

* **Service Unit Files**:

  * `/etc/systemd/system/` → Custom service files (admin-defined)
  * `/usr/lib/systemd/system/` → Default system services
* **Configuration files**:

  * Main: `/etc/systemd/system/*.service`
  * Drop-in overrides: `/etc/systemd/system/service_name.service.d/override.conf`
* **Logs**: `journalctl`
* **Legacy (SysV init)**: `/etc/init.d/` scripts (older systems)

---

## **3. Basic `systemctl` Commands**

### **Start, Stop, Restart, Reload**

```
systemctl start nginx       # Start service
systemctl stop nginx        # Stop service
systemctl restart nginx     # Restart service
systemctl reload nginx      # Reload without full restart
```

---

### **Enable/Disable at Boot**

```
systemctl enable nginx      # Start at boot
systemctl disable nginx     # Do not start at boot
```

---

### **Check Service Status**

```
systemctl status nginx
```

---

### **Check if Service is Enabled**

```
systemctl is-enabled nginx
```

---

### **View All Running Services**

```
systemctl list-units --type=service --state=running
```

---

### **View All Services**

```
systemctl list-unit-files --type=service
```

---

## **4. Controlling Daemons**

Daemons are just services managed by systemd. Example:

```
systemctl status sshd      # SSH daemon
systemctl restart sshd
```

---

## **5. Reload Systemd**

If a new service file is created or modified:

```
systemctl daemon-reload
```

---

## **6. Mask & Unmask a Service**

```
systemctl mask nginx    # Prevent service from starting (even manually)
systemctl unmask nginx
```

---

## **7. Logs for Services**

```
journalctl -u nginx           # View logs for nginx service
journalctl -u nginx --since "1 hour ago"
```

---

## **8. Run Service in Current Session Only**

```
systemctl start apache2.service
```

(Will not persist after reboot unless `enable` is used.)

---

## **9. View Failed Services**

```
systemctl --failed
```

---

## **10. Check Dependencies**

```
systemctl list-dependencies nginx
```

---

## ✅ **Real-World Examples**

### **1. Restart SSH Daemon after Config Change**

```
systemctl restart sshd
```

### **2. Enable Apache on Boot**

```
systemctl enable httpd
```

### **3. Stop & Mask a Service**

```
systemctl stop firewalld
systemctl mask firewalld
```

### **4. Monitor Logs for a Service**

```
journalctl -fu nginx
```

---

### **Legacy Commands (SysV)** (still work on some systems)

```
service nginx start
service nginx status
chkconfig nginx on   # Enable at boot (RHEL)
```

---

# ✅ **Custom Systemd Service File Example**

---

### **File Location**

Custom service files are usually placed in:

```
/etc/systemd/system/
```

---

### **Example: `/etc/systemd/system/myapp.service`**

```ini
[Unit]
Description=My Custom Application Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/myapp.sh
ExecStop=/bin/kill -TERM $MAINPID
Restart=on-failure
User=myuser
WorkingDirectory=/opt/myapp
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=myapp

[Install]
WantedBy=multi-user.target
```

---

### ✅ **Explanation of Each Section**

#### **\[Unit]**

* `Description=` → A short description of the service.
* `After=network.target` → Service starts **after network is up**.

#### **\[Service]**

* `Type=simple` → Runs the process specified in `ExecStart` as the main process (default type).
* `ExecStart=` → Full path to the command/script that starts the service.
* `ExecStop=` → Command to stop the service (optional).
* `Restart=on-failure` → Automatically restart on failure.
* `User=` → Runs the service as a specific user (security best practice).
* `WorkingDirectory=` → Directory where the service will run.
* `StandardOutput=syslog` → Redirects stdout to syslog.
* `StandardError=syslog` → Redirects stderr to syslog.
* `SyslogIdentifier=` → Name used in logs for this service.

#### **\[Install]**

* `WantedBy=multi-user.target` → Starts in **multi-user mode** (typical for servers).

---

### ✅ **Enable & Start the Service**

```
systemctl daemon-reload           # Reload systemd to recognize new service
systemctl enable myapp.service    # Enable at boot
systemctl start myapp.service     # Start the service now
systemctl status myapp.service    # Check status
```

---

### ✅ **View Logs**

```
journalctl -u myapp.service -f
```

---

### ✅ **Minimal Version**

If you just need a very basic service:

```ini
[Unit]
Description=My Simple Script

[Service]
ExecStart=/usr/local/bin/myscript.sh

[Install]
WantedBy=multi-user.target
```

---

Here’s the **complete Systemd Service Master Guide** in Markdown format, including **Python**, **Node.js**, and **Java** services with best practices.

---

# ✅ **Systemd Service Management – Complete Guide**

Systemd is the init system used by Linux to manage services and daemons. It provides better control than traditional init scripts.

---

## **📌 What is systemd?**

* A system and service manager for Linux operating systems.
* Handles service startup, dependency management, and logging.
* Service configuration files are usually stored in:

  * `/etc/systemd/system/` (custom services)
  * `/lib/systemd/system/` (default services)

---

## **📌 Key Commands**

```bash
systemctl start <service>      # Start a service
systemctl stop <service>       # Stop a service
systemctl restart <service>    # Restart a service
systemctl enable <service>     # Enable on boot
systemctl disable <service>    # Disable on boot
systemctl status <service>     # Check status
journalctl -u <service>        # View logs
```

---

## **📌 Anatomy of a Service File**

Example:

```ini
[Unit]
Description=My App Service
After=network.target

[Service]
User=myuser
Group=myuser
WorkingDirectory=/opt/myapp
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=10
StandardOutput=append:/var/log/myapp.log
StandardError=append:/var/log/myapp.log

[Install]
WantedBy=multi-user.target
```

---

# ✅ **1. Python Flask Application Service**

### **Service File**

`/etc/systemd/system/flaskapp.service`

```ini
[Unit]
Description=Flask Application Service
After=network.target

[Service]
User=flaskuser
Group=flaskuser
WorkingDirectory=/opt/flaskapp
Environment="FLASK_ENV=production"
Environment="PORT=5000"
ExecStart=/usr/bin/python3 /opt/flaskapp/app.py
Restart=always
RestartSec=5
StandardOutput=append:/var/log/flaskapp.log
StandardError=append:/var/log/flaskapp.log

[Install]
WantedBy=multi-user.target
```

---

# ✅ **2. Node.js Application Service**

### **Service File**

`/etc/systemd/system/nodeapp.service`

```ini
[Unit]
Description=Node.js Application Service
After=network.target

[Service]
User=nodeuser
Group=nodeuser
WorkingDirectory=/opt/nodeapp
Environment="NODE_ENV=production"
ExecStart=/usr/bin/node /opt/nodeapp/server.js
Restart=always
RestartSec=10
StandardOutput=append:/var/log/nodeapp.log
StandardError=append:/var/log/nodeapp.log

[Install]
WantedBy=multi-user.target
```

---

# ✅ **3. Java Spring Boot Application Service**

### **Service File**

`/etc/systemd/system/javaapp.service`

```ini
[Unit]
Description=Java Spring Boot Application Service
After=network.target

[Service]
User=javauser
Group=javauser
WorkingDirectory=/opt/javaapp
Environment="JAVA_OPTS=-Xms512m -Xmx1024m"
Environment="SPRING_PROFILES_ACTIVE=prod"
ExecStart=/usr/bin/java $JAVA_OPTS -jar /opt/javaapp/app.jar
Restart=always
RestartSec=10
StandardOutput=append:/var/log/javaapp.log
StandardError=append:/var/log/javaapp.log

[Install]
WantedBy=multi-user.target
```

---

## **✅ Steps to Deploy**

```bash
# 1. Create log files
touch /var/log/flaskapp.log /var/log/nodeapp.log /var/log/javaapp.log
chown flaskuser:flaskuser /var/log/flaskapp.log
chown nodeuser:nodeuser /var/log/nodeapp.log
chown javauser:javauser /var/log/javaapp.log

# 2. Reload systemd and enable services
systemctl daemon-reload
systemctl enable flaskapp nodeapp javaapp
systemctl start flaskapp nodeapp javaapp
```

---

## ✅ **Best Practices**

✔ Run services as **non-root users** (`flaskuser`, `nodeuser`, `javauser`)
✔ Store **sensitive environment variables** in `EnvironmentFile=/etc/myapp.env`
✔ Enable **auto-restart** with `Restart=always`
✔ Use `StandardOutput` & `StandardError` for **logging**
✔ Use **`systemctl status`** and **`journalctl -u <service>`** for troubleshooting

---

# ✅ **Diagram – How Systemd Works**

```
            ┌─────────────────────┐
            │      systemd        │
            ├─────────────────────┤
            │ Reads Unit Files    │
            │ (Service Config)    │
            └──────────┬──────────┘
                       │
         ┌─────────────┼─────────────┐
         ▼                           ▼
  [Flask Service]             [Node Service]
 (/opt/flaskapp)             (/opt/nodeapp)
         ▼                           ▼
    [Logging]                   [Logging]
  /var/log/flaskapp.log    /var/log/nodeapp.log
```

---
Here’s the **final extended guide** with **Security Hardening** + **30 Real-World Use Cases**.

---

# ✅ **Systemd Service Management – Complete Guide**

Includes:

* Basics of systemd
* Custom service files for **Python**, **Node.js**, **Java**
* **Security Hardening for Services**
* **30 Real-World Use Cases**

---

## **📌 What is systemd?**

* A system and service manager for Linux.
* Handles service startup, dependency management, and logging.
* Service files are stored in:

  * `/etc/systemd/system/` (custom)
  * `/lib/systemd/system/` (default)

---

## **📌 Key Commands**

```bash
systemctl start <service>
systemctl stop <service>
systemctl restart <service>
systemctl enable <service>
systemctl disable <service>
systemctl status <service>
journalctl -u <service>
```

---

## ✅ **Sample Service File Structure**

```ini
[Unit]
Description=My Custom App Service
After=network.target

[Service]
User=myuser
Group=myuser
WorkingDirectory=/opt/myapp
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=10
StandardOutput=append:/var/log/myapp.log
StandardError=append:/var/log/myapp.log

[Install]
WantedBy=multi-user.target
```

---

## ✅ **Python, Node.js, Java Examples**

(Already provided above – Flask, Node.js, Java Spring Boot)

---

# ✅ **Security Hardening for Systemd Services**

Systemd provides **resource control & security options** in `[Service]` section.

### **1. Restrict Resources**

```ini
CPUQuota=50%           # Limit CPU usage to 50%
MemoryLimit=512M       # Limit memory to 512MB
```

### **2. Secure the Environment**

```ini
NoNewPrivileges=true    # Prevent privilege escalation
ProtectSystem=full      # Make system directories read-only
PrivateTmp=true         # Give service its own /tmp
ProtectHome=true        # Restrict home directory access
ReadWritePaths=/opt/myapp # Allow write only in specific dir
```

### **3. Drop Capabilities**

```ini
CapabilityBoundingSet=CAP_NET_BIND_SERVICE  # Only allow binding to ports
```

### **4. Use Environment Files**

```ini
EnvironmentFile=/etc/myapp.env
```

---

## ✅ **Example Secure Service File**

```ini
[Unit]
Description=Secure Java App Service
After=network.target

[Service]
User=javauser
Group=javauser
WorkingDirectory=/opt/javaapp
EnvironmentFile=/etc/javaapp.env
ExecStart=/usr/bin/java $JAVA_OPTS -jar /opt/javaapp/app.jar

Restart=always
RestartSec=10

# Security
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=full
ProtectHome=true
CPUQuota=60%
MemoryLimit=1G

StandardOutput=append:/var/log/javaapp.log
StandardError=append:/var/log/javaapp.log

[Install]
WantedBy=multi-user.target
```

---

# ✅ **30 Real-World Use Cases for systemd Services**

| **Use Case** | **Description**                                   |
| ------------ | ------------------------------------------------- |
| 1            | Run a Python web server on boot                   |
| 2            | Run a Node.js API service                         |
| 3            | Deploy a Java Spring Boot microservice            |
| 4            | Auto-start database service (MySQL/PostgreSQL)    |
| 5            | Manage Docker or Podman as a service              |
| 6            | Run Nginx or Apache web server                    |
| 7            | Background file synchronization using `rsync`     |
| 8            | Backup script that runs continuously              |
| 9            | Run a Redis caching service                       |
| 10           | Run a RabbitMQ message broker                     |
| 11           | Auto-restart failed microservices                 |
| 12           | Start a VPN service on boot                       |
| 13           | Run a custom logging agent                        |
| 14           | Schedule cron-like jobs with systemd timers       |
| 15           | Monitor disk usage and send alerts                |
| 16           | Automate SSL certificate renewal with Certbot     |
| 17           | Deploy a Go web application                       |
| 18           | Deploy a PHP Laravel app with PHP-FPM             |
| 19           | Auto-run AI model inference service               |
| 20           | Run a queue consumer for Kafka or RabbitMQ        |
| 21           | Manage a containerized app without Docker Compose |
| 22           | Securely run background scripts without cron      |
| 23           | Automate log rotation & archiving                 |
| 24           | Continuous file watcher using `inotify`           |
| 25           | API Gateway service in microservices architecture |
| 26           | Email notification service                        |
| 27           | Real-time analytics service                       |
| 28           | Service to upload logs to AWS S3                  |
| 29           | Run a WebSocket server                            |
| 30           | Continuous data pipeline job                      |

---
