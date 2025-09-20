# Linux Learning Roadmap

## Legend:
- [ ] Not Started  
- [/] In Progress  
- [x] Completed  

---

## 1. Linux Introduction
- [ ] What is Linux?
- [/] Difference between Linux & Windows
- [ ] Linux Distributions (Ubuntu, CentOS, RHEL, Amazon Linux)
- [ ] CLI vs GUI

## 2. Kernel & Features
- [ ] Linux Kernel basics
- [ ] Kernel Space vs User Space
- [ ] Boot Process Overview (BIOS → GRUB → Kernel → init/systemd)
- [ ] Init vs systemd

## 3. Terminal Basics & Shortcuts
- [ ] Terminal vs Shell vs Console
- [ ] bash, sh, zsh
- [ ] Tab completion, history, clear, exit
- [ ] `man` pages
- [ ] Keyboard shortcuts (Ctrl + C, Ctrl + Z, etc.)

## 4. Basic Linux Commands
- [ ] File/Directory operations (`ls`, `cd`, `pwd`, `mkdir`, `rm`, `cp`, `mv`)
- [ ] Viewing content (`cat`, `less`, `more`, `head`, `tail`)
- [ ] Text search (`grep`, `find`, `locate`)
- [ ] Compression (`tar`, `gzip`, `zip`)
- [ ] Date/time commands

## 5. File System
- [ ] Linux directory structure (`/`, `/bin`, `/etc`, `/var`, `/usr`, `/home`)
- [ ] Absolute vs Relative paths
- [ ] Mount points
- [ ] File types (regular, directory, link, device)

## 6. Redirections
- [ ] Output redirection (`>`, `>>`)
- [ ] Input redirection (`<`)
- [ ] Error redirection (`2>`)
- [ ] Pipes (`|`)
- [ ] Combining commands

## 7. User Management
- [ ] Users & Groups
- [ ] `useradd`, `usermod`, `passwd`, `groupadd`
- [ ] `/etc/passwd`, `/etc/shadow`, `/etc/group`
- [ ] Switching users (`su`, `sudo`)

## 8. File Permissions & UMASK
- [ ] Read, Write, Execute permissions
- [ ] Owner, Group, Others
- [ ] `chmod`, `chown`, `chgrp`
- [ ] Special permissions (SUID, SGID, Sticky Bit)
- [ ] umask & default permissions

## 9. SSH
- [ ] SSH basics & keys
- [ ] Password vs key-based authentication
- [ ] `ssh`, `scp`, `sftp`
- [ ] SSH config files
- [ ] SSH hardening (port change, disabling root login)

## 10. Process Management
- [ ] Foreground vs Background processes
- [ ] `ps`, `top`, `htop`
- [ ] `kill`, `pkill`
- [ ] Jobs (`bg`, `fg`)
- [ ] Scheduling: `cron` & `at`

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
