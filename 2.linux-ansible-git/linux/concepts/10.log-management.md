# ✅ **Linux Logging Cheat Sheet (With Definitions)**

*(systemd-journald + /var/log + logrotate)*

---

## **1. What is Logging?**

Logging is the process of recording system, application, and security events for monitoring, troubleshooting, and auditing.

---

## **2. What is systemd-journald?**

`systemd-journald` is a logging service in modern Linux systems that:

* Collects logs from **kernel**, **system services**, and **applications**.
* Stores logs in **binary format** for structured querying.
* Uses the `journalctl` command to view logs.

---

## **3. What is /var/log?**

`/var/log` is a directory where **traditional text-based log files** are stored.

* Managed by **rsyslog** or similar services.
* Easy to view with `cat`, `less`, `tail`, and `grep`.

---

## **4. What is Log Rotation?**

**Log rotation** is the process of **automatically archiving old logs and creating new ones** to:

* Prevent logs from filling up disk space.
* Keep logs manageable and organized.
* Apply retention policies (e.g., keep logs for 7 days, compress old logs).
* Managed by **logrotate**.

**Config Files:**

* Main: `/etc/logrotate.conf`
* Per-service: `/etc/logrotate.d/`

**Manual rotation:**

```bash
sudo logrotate -f /etc/logrotate.conf
```

**Example rule:**

```
/var/log/httpd/*log {
    daily
    rotate 7
    compress
    missingok
    notifempty
}
```

* `daily` → Rotate logs daily
* `rotate 7` → Keep 7 old log files
* `compress` → Compress old logs
* `notifempty` → Do not rotate empty logs

---

## **5. Journald Commands**

* **View logs**

```bash
journalctl                      # All logs
journalctl -b                   # Current boot
journalctl -b -1                # Previous boot
journalctl -f                   # Follow logs
```

* **Filter logs**

```bash
journalctl -u sshd.service      # Service logs
journalctl --since "2025-09-01" # Time-based
journalctl -p err..alert        # Priority filter
```

* **Manage log size**

```bash
journalctl --disk-usage
sudo journalctl --vacuum-time=7d
sudo journalctl --vacuum-size=200M
```

---

## **6. /var/log Important Files**

| File                | Description                  |
| ------------------- | ---------------------------- |
| `/var/log/messages` | General system logs (RHEL)   |
| `/var/log/syslog`   | System logs (Ubuntu)         |
| `/var/log/auth.log` | Authentication logs (Ubuntu) |
| `/var/log/secure`   | Authentication logs (RHEL)   |
| `/var/log/dmesg`    | Kernel logs                  |
| `/var/log/boot.log` | Boot process logs            |
| `/var/log/cron`     | Cron job logs                |
| `/var/log/yum.log`  | Yum/DNF package logs         |

**View logs:**

```bash
tail -f /var/log/auth.log
grep "error" /var/log/messages
```

---

## **7. Binary Login Logs**

```bash
last -f /var/log/wtmp    # Login history
lastb -f /var/log/btmp   # Failed logins
lastlog                  # Last login for all users
```

---

## **8. journald vs /var/log**

| Feature  | journald            | /var/log      |
| -------- | ------------------- | ------------- |
| Format   | Binary              | Plain text    |
| Tool     | `journalctl`        | `cat`, `grep` |
| Location | `/var/log/journal/` | `/var/log/*`  |

---

✅ **One-Line Definition for Log Rotation (for interviews):**
*"Log rotation is the process of automatically archiving, compressing, or deleting old log files to manage disk space and maintain log history in a controlled way."*

---

# **Linux Log Files in `/var/log`**

---

## **1. Purpose**

* Stores system and application logs in **plain text** format.
* Used by tools like `rsyslog`, `syslog-ng`, or application-specific loggers.

---

## **2. Common Log Files in `/var/log`**

| File / Directory                         | Description                                |
| ---------------------------------------- | ------------------------------------------ |
| `/var/log/messages`                      | General system messages (kernel, services) |
| `/var/log/syslog`                        | System activity logs (Debian/Ubuntu)       |
| `/var/log/auth.log`                      | Authentication logs (Ubuntu/Debian)        |
| `/var/log/secure`                        | Authentication logs (RHEL/CentOS)          |
| `/var/log/dmesg`                         | Kernel ring buffer logs                    |
| `/var/log/boot.log`                      | Boot process logs                          |
| `/var/log/cron`                          | Cron job logs                              |
| `/var/log/maillog`                       | Mail server logs                           |
| `/var/log/httpd/` or `/var/log/apache2/` | Apache web server logs                     |
| `/var/log/nginx/`                        | Nginx logs                                 |
| `/var/log/yum.log`                       | Yum/DNF package manager logs               |
| `/var/log/dnf.log`                       | DNF logs                                   |
| `/var/log/kern.log`                      | Kernel logs                                |
| `/var/log/faillog`                       | Failed login attempts                      |
| `/var/log/wtmp`                          | Binary log for login history               |
| `/var/log/btmp`                          | Binary log for failed logins               |
| `/var/log/lastlog`                       | Binary log for last login of users         |

---

## **3. Viewing Logs**

* **View full log file**

  ```bash
  cat /var/log/messages
  ```
* **View last 50 lines**

  ```bash
  tail -n 50 /var/log/syslog
  ```
* **Follow logs in real-time**

  ```bash
  tail -f /var/log/auth.log
  ```
* **Search in logs**

  ```bash
  grep "sshd" /var/log/auth.log
  ```

---

## **4. Binary Logs (wtmp, btmp, lastlog)**

* Show login history:

  ```bash
  last -f /var/log/wtmp
  ```
* Show failed logins:

  ```bash
  lastb -f /var/log/btmp
  ```
* Show last login per user:

  ```bash
  lastlog
  ```

---

## **5. Log Rotation**

* Managed by `logrotate`:

  * Config file: `/etc/logrotate.conf`
  * Directory: `/etc/logrotate.d/`
* Rotate logs manually:

  ```bash
  sudo logrotate -f /etc/logrotate.conf
  ```

---

## **6. Compare journald vs /var/log**

| Feature        | journald                                  | /var/log (rsyslog)    |
| -------------- | ----------------------------------------- | --------------------- |
| Storage Format | Binary                                    | Plain text            |
| Location       | `/run/log/journal/` & `/var/log/journal/` | `/var/log/*`          |
| Viewer         | `journalctl`                              | `cat`, `less`, `tail` |
| Filtering      | Built-in (`journalctl -u`)                | Needs grep/awk        |

---

# **Linux Log Management & Journaling (systemd)**

---

## **1. What is systemd-journald?**

* `systemd-journald` is a logging service that collects logs from:

  * Kernel messages
  * System services
  * Applications (via `stdout`, `stderr`)
* Stores logs in **binary format** (not plain text) in `/var/log/journal/`

---

## **2. Log Storage**

* Default location:

  * **Volatile logs (RAM):** `/run/log/journal/`
  * **Persistent logs (Disk):** `/var/log/journal/` (enable with config)
* To make logs persistent:

  ```bash
  sudo mkdir -p /var/log/journal
  sudo systemd-tmpfiles --create --prefix /var/log/journal
  sudo systemctl restart systemd-journald
  ```

---

## **3. Viewing Logs (journalctl)**

* **View all logs**

  ```bash
  journalctl
  ```
* **View logs from boot**

  ```bash
  journalctl -b
  ```
* **View logs from previous boot**

  ```bash
  journalctl -b -1
  ```
* **Follow logs (like tail -f)**

  ```bash
  journalctl -f
  ```
* **Filter by time**

  ```bash
  journalctl --since "2025-09-01" --until "2025-09-04"
  journalctl --since "10 min ago"
  ```
* **Filter by unit (service)**

  ```bash
  journalctl -u sshd.service
  ```
* **Filter by priority**

  ```bash
  journalctl -p err..alert
  ```

  Priorities: `emerg`, `alert`, `crit`, `err`, `warning`, `notice`, `info`, `debug`

---

## **4. Log Size & Rotation**

* Check log disk usage:

  ```bash
  journalctl --disk-usage
  ```
* Limit size (edit config):

  ```bash
  sudo nano /etc/systemd/journald.conf
  ```

  Add/modify:

  ```
  SystemMaxUse=500M
  SystemKeepFree=50M
  RuntimeMaxUse=200M
  ```
* Apply changes:

  ```bash
  sudo systemctl restart systemd-journald
  ```

---

## **5. Export Logs**

* Save all logs to file:

  ```bash
  journalctl > /tmp/all-logs.txt
  ```
* Save logs for a specific service:

  ```bash
  journalctl -u sshd.service > sshd-logs.txt
  ```
* Export in JSON:

  ```bash
  journalctl -o json-pretty > logs.json
  ```

---

## **6. Clear Logs**

* Clear all journal logs:

  ```bash
  sudo journalctl --rotate
  sudo journalctl --vacuum-time=7d    # Keep last 7 days
  sudo journalctl --vacuum-size=200M # Limit to 200 MB
  ```

---

## **7. Enable Forwarding to syslog**

* Edit `/etc/systemd/journald.conf`:

  ```
  ForwardToSyslog=yes
  ```
* Restart:

  ```bash
  sudo systemctl restart systemd-journald
  ```

---

✅ **Key Files:**

* Config file: `/etc/systemd/journald.conf`
* Persistent logs: `/var/log/journal/`
* Volatile logs: `/run/log/journal/`

---

---

✅ **Key Takeaways:**

* **systemd-journald** = Modern, binary logs, queried with `journalctl`.
* **/var/log/** = Traditional text-based logs, easier to read manually.
* Both can coexist (journald can forward logs to `/var/log` via rsyslog).