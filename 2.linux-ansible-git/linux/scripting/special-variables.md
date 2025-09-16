# ✅ **Bash Special Variables Cheat Sheet**

---

## **📌 What are Special Variables in Bash?**

Special variables are predefined variables in Bash that hold **useful information about the script, arguments, exit status, and processes**.

---

## **1. `$0` – Script Name**

Represents the **name of the script being executed**.

```bash
#!/bin/bash
echo "Script name: $0"
```

**Output:**

```
Script name: ./myscript.sh
```

---

## **2. `$#` – Number of Arguments**

Shows the **number of positional arguments** passed to the script.

```bash
#!/bin/bash
echo "Number of arguments: $#"
```

**Run:**

```bash
./myscript.sh one two three
```

**Output:**

```
Number of arguments: 3
```

---

## **3. `$*` – All Arguments (Single Word)**

Expands to **all arguments as a single string**.

```bash
#!/bin/bash
echo "Arguments (as single string): $*"
```

**Run:**

```bash
./myscript.sh apple banana cherry
```

**Output:**

```
Arguments (as single string): apple banana cherry
```

---

## **4. `$@` – All Arguments (Separate Strings)**

Expands to **all arguments as separate quoted strings**.
✅ **Preferred for loops** because it preserves argument boundaries.

```bash
#!/bin/bash
for arg in "$@"; do
    echo "Arg: $arg"
done
```

**Run:**

```bash
./myscript.sh "apple pie" mango
```

**Output:**

```
Arg: apple pie
Arg: mango
```

---

## **5. `$1`, `$2`, ... – Positional Arguments**

Access specific arguments by position.

```bash
#!/bin/bash
echo "First argument: $1"
echo "Second argument: $2"
```

**Run:**

```bash
./myscript.sh one two
```

**Output:**

```
First argument: one
Second argument: two
```

---

## **6. `$?` – Exit Status of Last Command**

Returns the **exit status of the most recent command**.

* `0` = Success
* Non-zero = Error

```bash
#!/bin/bash
ls /etc/passwd
echo "Exit status: $?"

ls /nonexistent
echo "Exit status: $?"
```

**Output:**

```
/etc/passwd
Exit status: 0
ls: cannot access '/nonexistent': No such file or directory
Exit status: 2
```

✅ **Real-world use case:**

```bash
cp file.txt /backup/
if [ $? -eq 0 ]; then
    echo "Backup successful"
else
    echo "Backup failed"
fi
```

---

## **7. `$$` – PID of Current Script**

Prints the **process ID of the script**.

```bash
#!/bin/bash
echo "My PID is $$"
```

---

## **8. `$!` – PID of Last Background Process**

Returns the **PID of the last background process**.

```bash
#!/bin/bash
sleep 60 &
echo "Background process PID: $!"
```

---

## **9. `$_` – Last Argument of Previous Command**

Holds the **last argument from the previous command**.

```bash
ls /etc
echo "Last argument: $_"
```

**Output:**

```
Last argument: /etc
```

✅ Real-world trick:

```bash
touch myfile.txt
chmod 644 $_   # Applies chmod to last created file
```

---

### ✅ **Summary Table**

| Variable   | Meaning                           |
| ---------- | --------------------------------- |
| `$0`       | Script name                       |
| `$#`       | Number of arguments               |
| `$*`       | All arguments as a single string  |
| `$@`       | All arguments as separate strings |
| `$1`, `$2` | Positional arguments              |
| `$?`       | Exit status of last command       |
| `$$`       | PID of current script             |
| `$!`       | PID of last background process    |
| `$_`       | Last argument of previous command |

---

# ✅ **Bash Special Variables Ultimate Guide**

---

## **📌 What are Special Variables in Bash?**

Special variables are **predefined shell variables** that provide information about **scripts, arguments, processes, and statuses**. They are widely used in **automation, monitoring, and system scripts**.

---

## **1. Key Special Variables with Definitions**

| Variable        | Meaning                           |
| --------------- | --------------------------------- |
| `$0`            | Script name                       |
| `$#`            | Number of arguments               |
| `$*`            | All arguments as a single string  |
| `$@`            | All arguments as separate strings |
| `$1`, `$2`, ... | Positional arguments              |
| `$?`            | Exit status of last command       |
| `$$`            | PID of current shell/script       |
| `$!`            | PID of last background process    |
| `$_`            | Last argument of previous command |

---

## **2. Best Practices**

✔ Always **quote `$@` as `"$@"`** → Preserves argument boundaries.
✔ Avoid `$*` in loops; use `"$@"` instead.
✔ Check `$?` after critical commands for error handling.
✔ Use `$$` and `$!` for process tracking in background jobs.

---

## **3. Difference Between `$*` and `$@`**

| Variable | Behavior                                             |
| -------- | ---------------------------------------------------- |
| `"$*"`   | Expands all arguments as **one string**              |
| `"$@"`   | Expands all arguments as **separate quoted strings** |

**Example:**

```bash
for arg in "$*"; do echo "Arg: $arg"; done   # Single iteration
for arg in "$@"; do echo "Arg: $arg"; done   # Iterates over all arguments
```

---

## **4. Common Interview Questions**

✔ What is the difference between `$*` and `$@`?
✔ How do you get the exit status of the last command?
✔ How do you find the PID of the current script?
✔ How do you reference the last argument of the previous command?
✔ What is the use of `$!` in background processes?

---

## **5. ✅ 30 Real-World Examples**

---

### **🔹 Script Basics**

1. **Print script name and number of arguments**

```bash
echo "Script name: $0"
echo "Total arguments: $#"
```

2. **Print all arguments**

```bash
echo "All args as single string: $*"
echo "All args separately: $@"
```

---

### **🔹 Argument Handling**

3. **Access first and second argument**

```bash
echo "First: $1, Second: $2"
```

4. **Loop through all arguments**

```bash
for arg in "$@"; do
  echo "Arg: $arg"
done
```

---

### **🔹 Exit Status Handling**

5. **Check command success**

```bash
cp file.txt /backup/
if [ $? -eq 0 ]; then
  echo "Copy successful"
else
  echo "Copy failed"
fi
```

6. **Log exit status**

```bash
ls /etc/passwd
echo "Exit code: $?"
```

---

### **🔹 Process Management**

7. **Get script PID**

```bash
echo "Script PID: $$"
```

8. **Run job in background and print PID**

```bash
sleep 60 &
echo "Background PID: $!"
```

---

### **🔹 Previous Argument**

9. **Use last argument of previous command**

```bash
ls /etc
echo "Last argument: $_"
```

10. **Real case: chmod last created file**

```bash
touch file.txt
chmod 644 $_
```

---

### **🔹 Automation & Backup**

11. **Backup script with timestamp**

```bash
tar -czf backup-$(date +%F).tar.gz "$@"
```

12. **Check backup success**

```bash
tar -czf backup.tar.gz "$@" && echo "Backup successful" || echo "Backup failed"
```

13. **Kill background job after completion**

```bash
sleep 500 &
echo "Process PID: $!"
kill $!
```

---

### **🔹 Monitoring & Logging**

14. **Monitor process and log PID**

```bash
myapp &
echo "App started with PID: $!" >> process.log
```

15. **Check if last command failed**

```bash
command || echo "Command failed with exit code $?"
```

---

### **🔹 Argument Validation**

16. **Ensure at least 2 arguments**

```bash
if [ $# -lt 2 ]; then
  echo "Usage: $0 arg1 arg2"
  exit 1
fi
```

---

### **🔹 Advanced Loops**

17. **Print all args in uppercase**

```bash
for arg in "$@"; do
  echo "${arg^^}"
done
```

18. **Sum numeric arguments**

```bash
sum=0
for num in "$@"; do
  sum=$((sum + num))
done
echo "Total: $sum"
```

---

### **🔹 Error Handling**

19. **Retry command if it fails**

```bash
command || { echo "Retrying..."; command; }
```

20. **Exit if critical command fails**

```bash
critical_command || exit 1
```

---

### **🔹 Dynamic Commands**

21. **Pass all arguments to another command**

```bash
other_command "$@"
```

22. **Create archive from given directories**

```bash
tar -czf archive.tar.gz "$@"
```

---

### **🔹 Logging**

23. **Log script execution details**

```bash
echo "[$(date)] Script: $0, Args: $*, PID: $$" >> script.log
```

24. **Log errors using `$?`**

```bash
cp file /backup/ || echo "Error code: $?" >> error.log
```

---

### **🔹 System Tasks**

25. **Start a background job and save PID**

```bash
backup.sh &
echo $! > backup.pid
```

26. **Kill job using saved PID**

```bash
kill $(cat backup.pid)
```

---

### **🔹 Debugging**

27. **Show previous command argument**

```bash
echo "Last argument was: $_"
```

28. **Show current shell PID**

```bash
echo "Shell PID: $$"
```

---

### **🔹 Combined Automation**

29. **Process multiple files in loop**

```bash
for file in "$@"; do
  gzip "$file"
done
```

30. **Run script and exit if previous fails**

```bash
./deploy.sh && ./verify.sh || exit 1
```

---

## ✅ **Why This is Important**

* Frequently asked in **Linux Admin & DevOps interviews**.
* Used in **automation scripts**, **monitoring**, **CI/CD pipelines**.

---

### ✅ **Script Name:** `backup_manager.sh`

```bash
#!/bin/bash
# ==========================================
# Backup Manager Script - Demonstrates all Special Variables
# ==========================================

# Script Info
echo "Script Name: $0"
echo "Total Arguments: $#"
echo "All Args as single string: $*"
echo "All Args as separate strings: $@"
echo "First Arg: $1"
echo "Second Arg: $2"
echo "Current Script PID: $$"
echo "--------------------------------------"

# Argument validation
if [ $# -lt 2 ]; then
    echo "Usage: $0 <backup-dir> <file1> [file2 ...]"
    exit 1
fi

# Variables
BACKUP_DIR=$1
shift  # Remove first arg (backup directory) so remaining args are files
TIMESTAMP=$(date +%F-%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"

# Create backup in background
echo "Creating backup at: $BACKUP_FILE"
tar -czf "$BACKUP_FILE" "$@" &
BACKUP_PID=$!
echo "Backup started in background with PID: $BACKUP_PID"
echo "--------------------------------------"

# Wait for backup to finish
wait $BACKUP_PID
STATUS=$?
if [ $STATUS -eq 0 ]; then
    echo "Backup successful ✅"
else
    echo "Backup failed ❌ (Exit Code: $STATUS)"
    exit $STATUS
fi

# Demonstrate $_ (last argument of previous command)
echo "Last argument of previous command: $_"

# Log details
echo "[$(date)] Script: $0 | PID: $$ | Backup File: $BACKUP_FILE | Status: $STATUS" >> backup.log

# Show log file info
echo "Log updated in backup.log"
```

---

### ✅ **How this script uses all variables:**

✔ `$0` → Prints the script name.
✔ `$#` → Number of arguments passed.
✔ `$*` → All arguments as a single string.
✔ `$@` → All arguments separately (used in `tar`).
✔ `$1` → First argument (backup directory).
✔ `$?` → Exit status of `tar`.
✔ `$$` → Current script PID.
✔ `$!` → PID of background `tar` process.
✔ `$_` → Last argument of previous command (shows last processed file).

---

### ✅ **Run Example:**

```bash
./backup_manager.sh /tmp myfile1.txt myfile2.txt myfile3.txt
```

---

✅ **Do you want me to now:**
✔ Add **error handling (if backup directory doesn’t exist)**
✔ Add **automatic directory creation if missing**
✔ Add **logging of each special variable in `backup.log`**
✔ Add **email/notification feature for success/failure**

Or should I **keep it simple for GitHub cheat sheet**?

