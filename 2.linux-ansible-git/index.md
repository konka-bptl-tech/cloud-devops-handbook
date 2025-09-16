# 🐧 Linux Essentials for DevOps
---
## 1. OS, Kernel, Terminal & Shell
- What is an Operating System
- Linux Kernel and its Features
- Terminal vs Console vs Shell
- Bash Overview
- Command Line & Keyboard Shortcuts

## 2. Basic Linux Commands & File System
- pwd, cd, ls, mkdir, rm, mv, cp, touch
- File types: regular, directory, symbolic links
- Hard Links vs Soft Links

## 3. Redirection & SSH
- `>`, `>>`, `<`, `2>`, `2>&1`, `|`, `tee`
- SSH Configuration and Key-Based Authentication

## 4. User Management
- `useradd`, `usermod`, `passwd`, `id`, `groups`
- `/etc/passwd`, `/etc/shadow`

## 5. File Permissions
- `chmod`, `chown`, `chgrp`, symbolic & numeric mode
- umask value (default permission mask)
- Login profiles: `.bashrc`, `.bash_profile`, `.profile`

## 6. Package Management
- `apt`, `yum`, `dnf`, `rpm`
- `dpkg`, `snap`, `flatpak`

## 7. Process Management
- `ps`, `top`, `htop`, `kill`, `killall`, `nice`, `renice`

## 8. Service Management
- System V: `service`, `chkconfig`
- systemd: `systemctl`, `.service` units

## 9. Network Management
- `ip`, `ifconfig`, `ss`, `netstat`, `ping`, `traceroute`
- `hostname`, `/etc/hosts`, `/etc/resolv.conf`

## 10. Archiving & Compression
- `tar`, `gzip`, `gunzip`, `bzip2`, `xz`, `zip`, `unzip`

## 11. CRON Jobs (Scheduled Tasks)
- crontab format (`* * * * *`)
- `crontab -e`, `/etc/crontab`
- `at`, `anacron`

---

# 📜 Bash Scripting Fundamentals

---

## Basics
- ENV variables: `$HOME`, `$USER`, `$PATH`, `$?`
- Special variables: `$0`, `$1`, `$2`, `$@`, `$#`

## Functions
```bash
greet() {
  echo "Hello, $1!"
}
````

## Loops & Conditions

```bash
for i in {1..5}; do echo $i; done

if [[ $x -gt 10 ]]; then echo "Big"; fi
```

## Positional Arguments

* `$1`, `$2`, etc.
* `shift` command

## Text Processing Tools

* `grep` – search text
* `sed` – stream editor
* `awk` – data extraction & formatting
* `cut` – cut by delimiter
* `find` – locate files by name, size, modified time

---

# 🛠️ Ansible for DevOps Automation

---

## Introduction

* Agentless tool based on SSH
* Written in Python

## Push vs Pull Architecture

* Ansible = Push
* Pull (with ansible-pull or alternatives like Puppet)

## Ad-hoc Commands & Inventory

* Example: `ansible all -m ping`
* Inventory File: `/etc/ansible/hosts` or dynamic inventory
* Ansible Configuration File: `ansible.cfg`

## Playbooks

* YAML-based automation files

```yaml
- name: Install nginx
  hosts: web
  tasks:
    - name: install nginx
      apt:
        name: nginx
        state: present
```

## Roles

* Structured directory for reusability:

```
roles/
  └── web/
      ├── tasks/
      ├── handlers/
      ├── templates/
      └── vars/
```

## Variables, Loops, Conditions

* `with_items`, `when`, `vars_files`, `set_fact`

## Handlers

* Used for notifications like restarting services

## Vault (Secret Management)

* Encrypt sensitive data

```bash
ansible-vault encrypt secrets.yml
ansible-playbook site.yml --ask-vault-pass
```
