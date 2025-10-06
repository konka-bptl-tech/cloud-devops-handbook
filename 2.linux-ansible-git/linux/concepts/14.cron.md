# ✅ **Linux Cron Cheat Sheet (With Definitions)**

---

## **1. What is Cron?**

* **Cron** is a time-based job scheduler in Unix/Linux systems.
* Used to **automate repetitive tasks** (e.g., backups, log rotation, system monitoring).
* **Cron Daemon:** `crond` service runs in the background and executes scheduled jobs.

---

## **2. What is a Cron Job?**

* A **cron job** is a scheduled task defined in a **crontab file**.
* Syntax specifies **when** and **what** command should run.

---

## **3. Crontab Files**

* **User-specific crontab:**
  Location: `/var/spool/cron/<username>`
  Command to edit:

  ```bash
  crontab -e
  ```
* **System-wide crontab:**
  Location: `/etc/crontab`
* **Additional cron jobs:**
  Directories:

  * `/etc/cron.hourly/`
  * `/etc/cron.daily/`
  * `/etc/cron.weekly/`
  * `/etc/cron.monthly/`

---

## **4. Crontab Syntax**

```
*  *  *  *  *  command_to_run
|  |  |  |  |
|  |  |  |  └── Day of week (0-7) (0 or 7 = Sunday)
|  |  |  └──── Month (1-12)
|  |  └─────── Day of month (1-31)
|  └────────── Hour (0-23)
└───────────── Minute (0-59)
```

---

## **5. Examples**

```bash
* * * * * /path/to/script.sh           # Run every minute
0 * * * * /path/to/script.sh           # Run every hour
30 2 * * * /path/to/script.sh          # Run daily at 2:30 AM
0 0 * * 0 /path/to/script.sh           # Run every Sunday at midnight
*/10 * * * * /path/to/script.sh        # Run every 10 minutes
```

---

## **6. Manage Crontab**

* **Edit crontab for current user**

```bash
crontab -e
```

* **View crontab**

```bash
crontab -l
```

* **Remove crontab**

```bash
crontab -r
```

* **Edit root’s crontab**

```bash
sudo crontab -e
```

---

## **7. Special Keywords**

| Keyword    | Meaning          |
| ---------- | ---------------- |
| `@reboot`  | Run at startup   |
| `@daily`   | Run once a day   |
| `@hourly`  | Run every hour   |
| `@weekly`  | Run once a week  |
| `@monthly` | Run once a month |
| `@yearly`  | Run once a year  |

Example:

```bash
@reboot /path/to/script.sh
@daily  /path/to/script.sh
```

---

## **8. Cron Log Files**

* Check cron logs in:

  * **Ubuntu/Debian:** `/var/log/syslog`

    ```bash
    grep CRON /var/log/syslog
    ```
  * **RHEL/CentOS:** `/var/log/cron`

    ```bash
    tail -f /var/log/cron
    ```

---

## **9. Permissions**

* **Allow or deny cron access**

  * `/etc/cron.allow`
  * `/etc/cron.deny`

---

## **10. Definition for Interviews**

*"Cron is a Linux utility that schedules and automates tasks to run at specific times or intervals without manual intervention."*

---

✅ **Key Commands Summary**

```bash
crontab -e                  # Edit user crontab
crontab -l                  # List cron jobs
crontab -r                  # Remove cron jobs
grep CRON /var/log/syslog   # Check cron logs
```
---

# ✅ **Mastering Cron Expressions**

---

## **1. Cron Expression Format**

```
*  *  *  *  *  command
|  |  |  |  |
|  |  |  |  └── Day of week (0-7) (Sun=0 or 7)
|  |  |  └──── Month (1-12)
|  |  └─────── Day of month (1-31)
|  └────────── Hour (0-23)
└───────────── Minute (0-59)
```

### **Special Characters**

| Symbol | Meaning                               |
| ------ | ------------------------------------- |
| `*`    | Every possible value                  |
| `,`    | Multiple values (e.g., `1,15`)        |
| `-`    | Range (e.g., `1-5`)                   |
| `/`    | Step values (e.g., `*/5` for every 5) |

---

## **2. Basic Examples**

| Cron           | Meaning                  |
| -------------- | ------------------------ |
| `* * * * *`    | Every minute             |
| `0 * * * *`    | Every hour (at minute 0) |
| `0 0 * * *`    | Daily at midnight        |
| `0 12 * * *`   | Daily at 12 PM           |
| `0 9 * * 1-5`  | At 9 AM on weekdays      |
| `*/15 * * * *` | Every 15 minutes         |

---

## **3. Advanced Tricks**

### **Run every 10 minutes during working hours (9 AM - 6 PM)**

```
*/10 9-18 * * *
```

### **Run at 5 PM on weekdays only**

```
0 17 * * 1-5
```

### **Run every Monday and Wednesday at 3:30 PM**

```
30 15 * * 1,3
```

### **Run on the first day of every month at midnight**

```
0 0 1 * *
```

### **Run last day of the month at midnight (Advanced)**

```
0 0 28-31 * * [ "$(date +\%d -d tomorrow)" == "01" ] && command
```

*(Uses date check in script because cron alone doesn’t support “last day” natively.)*

### **Run every 5 minutes but only during the first 10 minutes of every hour**

```
*/5 0-10 * * *
```

### **Run every Sunday at 2 AM**

```
0 2 * * 0
```

---

## **4. Special Strings**

| String     | Meaning                                  |
| ---------- | ---------------------------------------- |
| `@reboot`  | At system startup                        |
| `@hourly`  | Every hour                               |
| `@daily`   | Every day at midnight                    |
| `@weekly`  | Every week at midnight on Sunday         |
| `@monthly` | Every month at midnight on the first day |
| `@yearly`  | Every year at midnight on Jan 1          |

Example:

```bash
@daily /path/to/backup.sh
```

---

## **5. Validate Cron Expressions**

* **Online Tools:**

  * [crontab.guru](https://crontab.guru) (Best for quick checks)
* **Linux Test Command:**

```bash
echo "* * * * * echo 'Hello'" | crontab -
```

---

## **6. Pro Tips**

✅ Use `*/N` for intervals (e.g., `*/5` for every 5 mins).
✅ Combine ranges and steps: `0-30/10` = 0,10,20,30.
✅ Combine days & months for quarterly jobs: `0 0 1 1,4,7,10 *`.
✅ Redirect output to logs:

```bash
* * * * * /script.sh >> /var/log/myscript.log 2>&1
```

✅ Always use full paths in scripts (cron has minimal environment).

---

### **Practice Questions**

1. Every 30 mins between 9 AM and 5 PM on weekdays?
2. Every Sunday at midnight?
3. First Monday of every month? *(Hint: use script logic)*
4. Every 5 mins only during office hours (Mon-Fri, 9 AM - 6 PM)?

---

# ✅ 30 Real-World Cron Job Examples with Explanations

---

### **1. Run every minute**

```
* * * * *
```

Runs every minute of every hour, every day.

---

### **2. Run every 5 minutes**

```
*/5 * * * *
```

---

### **3. Run every hour**

```
0 * * * *
```

---

### **4. Run daily at midnight**

```
0 0 * * *
```

---

### **5. Run daily at 6 PM**

```
0 18 * * *
```

---

### **6. Run every Sunday at 2 AM**

```
0 2 * * 0
```

---

### **7. Run every weekday at 9 AM**

```
0 9 * * 1-5
```

---

### **8. Run every 10 minutes during working hours (9 AM - 6 PM)**

```
*/10 9-18 * * *
```

---

### **9. Run every Saturday and Sunday at 8 AM**

```
0 8 * * 6,0
```

---

### **10. Run on the first day of the month at midnight**

```
0 0 1 * *
```

---

### **11. Run on the last day of the month at 11:59 PM**

*(Requires script logic because cron alone does not support "last day"):*

```
59 23 28-31 * * [ "$(date +\%d -d tomorrow)" == "01" ] && command
```

---

### **12. Run every quarter (Jan, Apr, Jul, Oct) on the 1st at 1 AM**

```
0 1 1 1,4,7,10 *
```

---

### **13. Run every year on Jan 1 at midnight**

```
0 0 1 1 *
```

---

### **14. Run every Monday at 6 AM**

```
0 6 * * 1
```

---

### **15. Run every 30 minutes**

```
*/30 * * * *
```

---

### **16. Run every 15 minutes between 8 AM and 5 PM**

```
*/15 8-17 * * *
```

---

### **17. Run every 2 hours**

```
0 */2 * * *
```

---

### **18. Run every day at 11:59 PM**

```
59 23 * * *
```

---

### **19. Run every 5 minutes only on weekdays**

```
*/5 * * * 1-5
```

---

### **20. Run every day at 3 AM and 3 PM**

```
0 3,15 * * *
```

---

### **21. Run every Sunday and Wednesday at 10 PM**

```
0 22 * * 0,3
```

---

### **22. Run every day at 8 AM except Sundays**

```
0 8 * * 1-6
```

---

### **23. Run every 10 seconds**

*(Cron cannot do seconds by default – use a script with `sleep` or `systemd` timer)*

---

### **24. Run at 11:30 PM on the last Friday of the month**

```
30 23 25-31 * 5 [ "$(date +\%a -d tomorrow)" == "Sat" ] && command
```

---

### **25. Run at midnight on 29th February (Leap Year)**

```
0 0 29 2 *
```

---

### **26. Run every 10th day of the month**

```
0 0 10,20,30 * *
```

---

### **27. Run every hour from 9 AM to 5 PM on weekdays**

```
0 9-17 * * 1-5
```

---

### **28. Run every 5 mins only during first 10 mins of every hour**

```
*/5 0-10 * * *
```

---

### **29. Run at 6:15 PM every day**

```
15 18 * * *
```

---

### **30. Run backup script every night at 1 AM and redirect logs**

```
0 1 * * * /path/to/backup.sh >> /var/log/backup.log 2>&1
```

---

✅ These examples cover:

* Basic scheduling
* Weekday/weekend jobs
* Advanced date-based jobs
* Real production scenarios (backup, reports, etc.)

---
