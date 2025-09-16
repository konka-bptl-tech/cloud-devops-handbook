# ✅ **Bash Loops Cheat Sheet**

---

## **📌 What is a Loop in Bash?**

A **loop** allows you to execute a block of code repeatedly until a certain condition is met.
Common loops in Bash:

* **for loop**
* **while loop**
* **until loop**
* **select loop**

---

## **1. `for` Loop**

### **Syntax:**

```bash
for var in list
do
   commands
done
```

### **Example 1: Simple loop**

```bash
for i in 1 2 3 4 5
do
    echo "Number: $i"
done
```

---

### **Example 2: Using brace expansion**

```bash
for i in {1..5}
do
    echo "Number: $i"
done
```

---

### **Example 3: With step value**

```bash
for i in {0..10..2}
do
    echo "Even: $i"
done
```

---

### **Example 4: Loop through arguments (`$@`)**

```bash
for arg in "$@"
do
    echo "Argument: $arg"
done
```

---

## **2. `while` Loop**

### **Syntax:**

```bash
while [ condition ]
do
    commands
done
```

### **Example 1: Countdown**

```bash
count=5
while [ $count -gt 0 ]
do
    echo "Countdown: $count"
    count=$((count - 1))
done
```

---

### **Example 2: Read file line by line**

```bash
while read line
do
    echo "Line: $line"
done < file.txt
```

---

## **3. `until` Loop**

Runs **until the condition becomes true** (opposite of while).

### **Example:**

```bash
count=1
until [ $count -gt 5 ]
do
    echo "Count: $count"
    count=$((count + 1))
done
```

---

## **4. `select` Loop (Menu)**

Creates a **simple menu** for user selection.

### **Example:**

```bash
select choice in Start Stop Exit
do
    case $choice in
        Start) echo "Starting service..." ;;
        Stop) echo "Stopping service..." ;;
        Exit) break ;;
        *) echo "Invalid option" ;;
    esac
done
```

---

## ✅ **Loop Control Statements**

* `break` → Exit the loop.
* `continue` → Skip current iteration.

### **Example:**

```bash
for i in {1..5}
do
    if [ $i -eq 3 ]; then
        continue
    fi
    echo "Number: $i"
done
```

---

## ✅ **C-Style `for` Loop**

```bash
for ((i=0; i<5; i++))
do
    echo "Index: $i"
done
```

---

## ✅ **Real-World Use Cases**

✔ Loop over files:

```bash
for file in *.txt
do
    echo "Processing $file"
done
```

✔ Ping multiple servers:

```bash
for host in server1 server2 server3
do
    ping -c 1 "$host" && echo "$host is up" || echo "$host is down"
done
```

✔ Monitor process every 5 sec:

```bash
while true
do
    ps aux | grep nginx
    sleep 5
done
```

---
## **30 Real-World Loop Examples**

---

### ✅ **FOR LOOP Examples**

1. **Print numbers from 1 to 10**

```bash
for i in {1..10}; do echo $i; done
```

2. **Iterate through files in a directory**

```bash
for file in /var/log/*.log; do echo "File: $file"; done
```

3. **Backup all `.conf` files**

```bash
for f in /etc/*.conf; do cp $f /backup/; done
```

4. **Loop through arguments**

```bash
for arg in "$@"; do echo "Argument: $arg"; done
```

5. **Check disk usage for multiple partitions**

```bash
for mount in / /home /var; do df -h $mount; done
```

---

### ✅ **WHILE LOOP Examples**

6. **Countdown from 10 to 1**

```bash
count=10
while [ $count -gt 0 ]; do
    echo $count
    ((count--))
done
```

7. **Read a file line by line**

```bash
while read line; do echo "$line"; done < file.txt
```

8. **Monitor CPU usage every 5 seconds**

```bash
while true; do
    top -bn1 | grep "Cpu(s)"
    sleep 5
done
```

9. **Check if a service is running**

```bash
while ! systemctl is-active --quiet nginx; do
    echo "Waiting for nginx to start..."
    sleep 2
done
```

10. **Ping a host until reachable**

```bash
while ! ping -c1 google.com &>/dev/null; do
    echo "Waiting for network..."
    sleep 3
done
```

---

### ✅ **UNTIL LOOP Examples**

11. **Wait until a file exists**

```bash
until [ -f /tmp/ready.txt ]; do
    echo "Waiting for file..."
    sleep 2
done
```

12. **Until a process starts**

```bash
until pgrep java >/dev/null; do
    echo "Waiting for Java process..."
    sleep 1
done
```

---

### ✅ **NESTED LOOPS**

13. **Multiplication table**

```bash
for i in {1..3}; do
    for j in {1..3}; do
        echo "$i x $j = $((i*j))"
    done
done
```

---

### ✅ **DEVOPS & ADMIN TASKS**

14. **Restart multiple services**

```bash
for svc in nginx sshd docker; do
    systemctl restart $svc
done
```

15. **Create multiple users**

```bash
for user in user1 user2 user3; do
    useradd $user
done
```

16. **Check multiple URLs**

```bash
for url in google.com yahoo.com; do
    curl -Is $url | head -1
done
```

17. **Find large files**

```bash
for dir in /home /var/log; do
    find $dir -type f -size +100M
done
```

18. **Monitor memory usage continuously**

```bash
while true; do
    free -m
    sleep 5
done
```

19. **Send alerts if disk usage > 80%**

```bash
while true; do
    usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ $usage -gt 80 ]; then
        echo "Disk usage critical!"
    fi
    sleep 60
done
```

20. **Backup logs daily using cron + loop**

```bash
for log in /var/log/*.log; do
    gzip $log
done
```

21. **Monitor failed login attempts**

```bash
while true; do
    tail -n 50 /var/log/auth.log | grep "Failed"
    sleep 10
done
```

22. **Check Kubernetes pods every 10 sec**

```bash
while true; do
    kubectl get pods
    sleep 10
done
```

23. **Check AWS EC2 instance status**

```bash
for id in $(aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output text); do
    aws ec2 describe-instance-status --instance-ids $id
done
```

24. **Delete old backups**

```bash
for f in /backup/*; do
    if [[ $(stat -c %Y $f) -lt $(date -d '-7 days' +%s) ]]; then
        rm $f
    fi
done
```

25. **Loop to check open ports**

```bash
for port in 22 80 443; do
    nc -zv localhost $port
done
```

26. **Automate Docker image cleanup**

```bash
for img in $(docker images -q); do
    docker rmi $img
done
```

27. **Loop through Git repos for status**

```bash
for repo in /projects/*; do
    (cd $repo && git status)
done
```

28. **Process monitoring and alert**

```bash
while true; do
    if ! pgrep nginx >/dev/null; then
        echo "Nginx is down!"
    fi
    sleep 10
done
```

29. **Deploy multiple microservices**

```bash
for svc in auth cart payment; do
    kubectl apply -f $svc.yaml
done
```

30. **Generate 100 test files**

```bash
for i in {1..100}; do
    touch file_$i.txt
done
```

---

## **Best Practices**

✔ Always **quote variables**: `"$var"`
✔ Prefer **`$@` over `$*`** (to preserve arguments with spaces)
✔ Use **`set -e`** in scripts for safety
✔ Use `sleep` for loops that poll continuously
✔ Use `break` and `continue` wisely

---

## **Common Interview Questions**

1. Difference between `for`, `while`, and `until` loops?
2. When would you use `while true` in automation?
3. How do you avoid infinite loops?
4. Why is `$@` better than `$*` in most cases?
5. How to read a file line by line using a loop?

---

### **📂 loops-devops-automation.sh**

```bash
#!/bin/bash
# Title: Loops & DevOps Automation Script
# Description: Demonstrates for, while, until loops with real-world DevOps use cases

set -e  # Exit on error

echo "Total arguments: $#"
echo "All arguments (separate): $@"
echo "First argument: $1"
echo "Last argument of previous command: $_"

echo "---------------------------------"
echo "1. FOR LOOP – Restart multiple services"
echo "---------------------------------"
services=("nginx" "docker" "sshd")
for svc in "${services[@]}"; do
    echo "Restarting $svc..."
    systemctl restart "$svc" || echo "Failed to restart $svc"
done

echo "---------------------------------"
echo "2. FOR LOOP – Deploy multiple Kubernetes YAMLs"
echo "---------------------------------"
for svc in auth cart payment; do
    echo "Applying $svc.yaml"
    kubectl apply -f "$svc.yaml"
done

echo "---------------------------------"
echo "3. WHILE LOOP – Monitor CPU every 5 sec"
echo "---------------------------------"
count=0
while [ $count -lt 3 ]; do
    echo "CPU Usage at $(date):"
    top -bn1 | grep "Cpu(s)"
    ((count++))
    sleep 5
done

echo "---------------------------------"
echo "4. UNTIL LOOP – Wait until file exists"
echo "---------------------------------"
file="/tmp/ready.txt"
echo "Creating $file in 10 sec (simulation)..."
(sleep 10 && touch $file) &
until [ -f "$file" ]; do
    echo "Waiting for $file..."
    sleep 2
done
echo "$file found!"

echo "---------------------------------"
echo "5. WHILE LOOP – Disk usage alert (>80%)"
echo "---------------------------------"
check_count=0
while [ $check_count -lt 2 ]; do
    usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ $usage -gt 80 ]; then
        echo "CRITICAL: Disk usage is $usage%"
    else
        echo "Disk usage is OK: $usage%"
    fi
    ((check_count++))
    sleep 5
done

echo "---------------------------------"
echo "6. FOR LOOP – Backup config files"
echo "---------------------------------"
backup_dir="/backup"
mkdir -p "$backup_dir"
for f in /etc/*.conf; do
    cp "$f" "$backup_dir/"
done
echo "Backup complete in $backup_dir"

echo "---------------------------------"
echo "7. FOR LOOP – Docker image cleanup"
echo "---------------------------------"
for img in $(docker images -q); do
    echo "Removing image $img"
    docker rmi "$img" || echo "Failed to remove image $img"
done

echo "---------------------------------"
echo "8. WHILE LOOP – Monitor Nginx process"
echo "---------------------------------"
loop_count=0
while [ $loop_count -lt 3 ]; do
    if ! pgrep nginx >/dev/null; then
        echo "Nginx is down! Restarting..."
        systemctl restart nginx
    else
        echo "Nginx is running"
    fi
    ((loop_count++))
    sleep 5
done

echo "---------------------------------"
echo "Script Completed Successfully!"
```

---

### ✅ **What This Script Covers**

✔ Uses **`$#`, `$@`, `$1`, `$_`** (special variables)
✔ Includes **`for`, `while`, `until` loops**
✔ Handles **real DevOps tasks**:

* Restart services
* Deploy Kubernetes YAMLs
* Monitor CPU
* Wait for file creation
* Check disk usage
* Backup configs
* Clean Docker images
* Monitor and auto-restart Nginx
  ✔ Includes **error handling (`set -e`)**

---

### ✅ **How to Run**

```bash
chmod +x loops-devops-automation.sh
./loops-devops-automation.sh arg1 arg2
```

---
