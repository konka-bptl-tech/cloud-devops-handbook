# Linux Learning Roadmap

## 1. Linux Introduction
1. OS
2. Kernal & Features
3. Command
4. Shell
5. Terminal
6. Terminal Shortcuts

## 2. Kernel & Features
1. Linux Kernel basics
2. Kernel Space vs User Space
3. Boot Process Overview (BIOS → GRUB → Kernel → init/systemd)
4. Init vs systemd
5. Profile files

## 3. Basic linux Commands
1. File/Directory Commands
2. Viewing Contennt
3. Text Search
4. Data & time Commands
5. man pages

## 4. File System
1. Linux directory structure (`/`, `/bin`, `/etc`, `/var`, `/usr`, `/home`)
2. Absolute vs Relative paths
3. Mount points
4. File types (regular, directory, link, device)
5. Soft & Hard Links
6. Directory special entries

## 5. Redirections
1. Output redirection (`>`, `>>`)
2. Input redirection (`<`)
3. Error redirection (`2>`)
4. Pipes (`|`)
5. Combining commands
6. tee

## 6. User Management
1. Authentication & Authroization
2. Users & Groups & System Users
3. `useradd`, `usermod`, `passwd`, `groupadd`
4. `/etc/passwd`, `/etc/shadow`, `/etc/group`
5. Switching users (`su`, `sudo`)


## 7. File Permissions & UMASK
1. Read, Write, Execute permissions
2. Owner, Group, Others
3. `chmod`, `chown`, `chgrp`
4. Special permissions (SUID, SGID, Sticky Bit)
5. umask & default permissions

## 8. SSH
1. SSH basics & keys
2. Password vs key-based authentication
3. `ssh`, `scp`, `sftp`
4. SSH config files
5. SSH hardening (port change, disabling root login)

## 9. Process Management
1. Foreground vs Background processes
2. `ps`, `top`, `htop`
3. `kill`, `pkill`
4. Jobs (`bg`, `fg`)
6. All Commands

## 11. Log Management
- [ ] `/var/log` directory
- [ ] `journalctl` (systemd logs)
- [ ] `dmesg` (kernel logs)
- [ ] Log rotation (`logrotate`)

## 12. Package Management
- [ ] RPM & YUM (RHEL/CentOS/Amazon Linux)
- [ ] APT (Debian/Ubuntu)
- [ ] `rpm`, `yum`, `dnf`, `apt-get`
- [ ] Adding repositories

## 13. Service Management
- [ ] init.d vs systemd
- [ ] `service` command
- [ ] `systemctl` (start, stop, enable, disable, status)
- [ ] Checking port usage (`netstat`, `ss`)

## 14. Network Management
- [ ] Checking IP address (`ip`, `ifconfig`)
- [ ] Network interfaces & routing
- [ ] `ping`, `curl`, `wget`, `traceroute`
- [ ] Firewall basics (`iptables`, `firewalld`)
- [ ] DNS Resolution (`/etc/resolv.conf`, `dig`, `nslookup`)

## 15. Disk Management
- [ ] Checking disk usage (`df`, `du`)
- [ ] `mount`, `umount`
- [ ] Creating & formatting partitions (`fdisk`, `mkfs`)
- [ ] `lsblk`, `blkid`
- [ ] LVM basics (create, extend, reduce)
- [ ] `swap` space

## 16. CRON Jobs
- [ ] Introduction to CRON & its daemon
- [ ] User-level crontab vs system crontab
- [ ] `crontab -e`, `crontab -l`, `crontab -r`
- [ ] CRON syntax (`* * * * *`)
- [ ] Redirecting output to log files
- [ ] `/etc/crontab`, `/etc/cron.hourly`, `/etc/cron.daily`, `/etc/cron.weekly`
- [ ] One-time jobs with `at`
- [ ] Security: `/etc/cron.allow` and `/etc/cron.deny`



---

# Bash Scripting Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. Variables & Special Variables
- [ ] Declaring variables
- [ ] Using variables in scripts
- [ ] Environment variables vs local variables
- [ ] Exporting variables (`export`)
- [ ] Special variables (`$0`, `$1`, `$#`, `$?`, `$@`, `$*`)
- [ ] Reading user input (`read`)

## 2. Loops
- [ ] `for` loops
- [ ] `while` loops
- [ ] `until` loops
- [ ] Loop control (`break`, `continue`)
- [ ] Iterating over files, numbers, and command output

## 3. Conditions
- [ ] `if`, `elif`, `else`
- [ ] `[ ]` vs `[[ ]]` test conditions
- [ ] String comparisons
- [ ] Numeric comparisons
- [ ] File checks (`-f`, `-d`, `-e`, `-r`, `-w`, `-x`)
- [ ] `case` statements

## 4. Functions
- [ ] Defining functions
- [ ] Passing arguments to functions
- [ ] Returning values from functions
- [ ] Scope of variables in functions
- [ ] Using `source` or `.` to include functions

## 5. SED, CUT, AWK, GREP
- [ ] `grep` basics & options
- [ ] Using `cut` for column extraction
- [ ] `sed` basics (search & replace)
- [ ] `sed` advanced usage (delete, insert, append lines)
- [ ] `awk` basics (field processing)
- [ ] `awk` advanced usage (patterns, actions, variables)


