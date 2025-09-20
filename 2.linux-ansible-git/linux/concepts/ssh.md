````markdown
# SSH (Secure Shell) Cheat Sheet

## ✅ What is SSH?
SSH, or Secure Shell, is a cryptographic protocol used to securely log in to remote systems, run commands, and transfer files over an unsecured network. It replaces insecure protocols like Telnet by providing encrypted communication, strong authentication, and integrity protection

**Purpose of SSH:**
- Secure remote login to servers
- Secure file transfer (SCP, SFTP)
- Remote command execution
- Tunneling and port forwarding

---

## ✅ SSH Configuration File Locations

| File | Purpose |
|------|---------|
| `/etc/ssh/sshd_config` | **Server-side config** (SSH daemon settings) |
| `/etc/ssh/ssh_config` | **Global client config** |
| `~/.ssh/config` | **User-specific client config** |
| `~/.ssh/id_rsa` | Private key (default for authentication) |
| `~/.ssh/id_rsa.pub` | Public key |
| `~/.ssh/authorized_keys` | List of public keys allowed to connect |
| `/var/log/secure` (RHEL) or `/var/log/auth.log` (Ubuntu) | SSH logs |

---

## ✅ Basic SSH Commands

| Action | Command |
|--------|---------|
| Connect to a remote server | `ssh user@hostname` |
| Connect with specific port | `ssh -p 2222 user@hostname` |
| Connect with key file | `ssh -i /path/to/key user@hostname` |
| Run a remote command | `ssh user@hostname "ls -l /var/log"` |
| Increase verbosity (debug) | `ssh -v user@hostname` |

---

## ✅ SSH Key Management

### 🔹 Generate SSH Key Pair
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
````

### 🔹 Copy Public Key to Server (Passwordless Login)

```bash
ssh-copy-id user@hostname
# OR manually:
cat ~/.ssh/id_rsa.pub | ssh user@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

### 🔹 Change Key Permissions

```bash
chmod 600 ~/.ssh/id_rsa
chmod 700 ~/.ssh
```

---

## ✅ SSH Client Config (\~/.ssh/config)

Example:

```
Host myserver
    HostName 192.168.1.10
    User ubuntu
    Port 2222
    IdentityFile ~/.ssh/id_rsa
```

Then connect using:

```bash
ssh myserver
```

---

## ✅ SSH Server Config (/etc/ssh/sshd\_config)

Common settings:

```
Port 22
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
```

After changes:

```bash
sudo systemctl restart sshd
```

---

## ✅ File Transfer using SSH

| Action                | Command                                              |
| --------------------- | ---------------------------------------------------- |
| Copy file to remote   | `scp file.txt user@host:/path/`                      |
| Copy file from remote | `scp user@host:/path/file.txt .`                     |
| Sync directories      | `rsync -avz -e ssh /local/dir user@host:/remote/dir` |

---

## ✅ Advanced SSH Usage

| Feature                               | Command                                     |
| ------------------------------------- | ------------------------------------------- |
| Local Port Forwarding                 | `ssh -L 8080:localhost:80 user@host`        |
| Remote Port Forwarding                | `ssh -R 9090:localhost:22 user@host`        |
| Dynamic Port Forwarding (SOCKS proxy) | `ssh -D 1080 user@host`                     |
| Multiplexing (reuse connection)       | Add `ControlMaster auto` in `~/.ssh/config` |

---

## ✅ SSH Service Management (Linux)

| Action                   | Command                       |
| ------------------------ | ----------------------------- |
| Check SSH service status | `systemctl status sshd`       |
| Restart SSH service      | `sudo systemctl restart sshd` |
| Enable SSH on boot       | `sudo systemctl enable sshd`  |

---

## ✅ Security Best Practices

* Disable **root login** (`PermitRootLogin no`)
* Disable **password authentication** (`PasswordAuthentication no`)
* Use **key-based authentication**
* Change default SSH port
* Enable **fail2ban** for brute-force protection


---

## ✅ **What is Fail2ban?**

Fail2ban is a security tool that **monitors log files for repeated failed login attempts** (e.g., SSH) and **bans IP addresses** by updating the firewall rules (e.g., iptables, firewalld).

---

## ✅ **Steps to Enable Fail2ban for SSH**

### **1. Install Fail2ban**

**On RHEL / CentOS / Fedora:**

```bash
sudo yum install fail2ban -y
```

**On Ubuntu / Debian:**

```bash
sudo apt install fail2ban -y
```

---

### **2. Enable and Start Fail2ban Service**

```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

Check status:

```bash
sudo systemctl status fail2ban
```

---

### **3. Create/Modify Jail Configuration for SSH**

Fail2ban uses **jail** configuration files to define rules.

**Copy default file to local:**

```bash
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

Edit:

```bash
sudo nano /etc/fail2ban/jail.local
```

Add or modify:

```
[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/secure    # RHEL/CentOS
# logpath = /var/log/auth.log  # Ubuntu/Debian
maxretry = 5
bantime = 600
findtime = 600
```

**Explanation:**

* `enabled = true` → Enable SSH jail
* `maxretry = 5` → Block after 5 failed attempts
* `bantime = 600` → Ban IP for 10 minutes
* `findtime = 600` → Count failures within 10 minutes

---

### **4. Restart Fail2ban**

```bash
sudo systemctl restart fail2ban
```

---

### **5. Check Fail2ban Status for SSH**

```bash
sudo fail2ban-client status sshd
```

**Output example:**

```
Status for the jail: sshd
|- Filter
|  |- Currently failed: 0
|  `- Total failed: 3
`- Actions
   |- Currently banned: 1
   `- Banned IP list: 192.168.1.50
```

---

### **6. Unban an IP (if needed)**

```bash
sudo fail2ban-client set sshd unbanip <IP_ADDRESS>
```

---

## ✅ **Extra Security Tips**

✔ Increase `bantime` for repeated offenders
✔ Use `ignoreip` to whitelist your IP in `/etc/fail2ban/jail.local`:

```
ignoreip = 127.0.0.1/8 <your-ip>
```

---