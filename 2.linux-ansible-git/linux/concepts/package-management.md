# Linux Package Management Cheat Sheet

## 📌 What is Package Management?
Package management is the process of **installing, updating, upgrading, configuring, and removing software packages** in Linux.

- **Package Types**:
  - RHEL/CentOS/Fedora → `.rpm` files → `yum` / `dnf` package manager
  - Ubuntu/Debian → `.deb` files → `apt` / `dpkg` package manager

---

## ✅ RHEL / CentOS / Fedora (YUM & DNF)

### 🔹 Basic Commands
| Action | Command |
|--------|---------|
| Install package | `sudo yum install <package>` OR `sudo dnf install <package>` |
| Remove package | `sudo yum remove <package>` OR `sudo dnf remove <package>` |
| Update a package | `sudo yum update <package>` OR `sudo dnf update <package>` |
| Update all packages | `sudo yum update -y` OR `sudo dnf upgrade -y` |
| Check updates | `yum check-update` OR `dnf check-update` |
| Search package | `yum search <package>` OR `dnf search <package>` |
| Show package info | `yum info <package>` OR `dnf info <package>` |
| List installed packages | `rpm -qa` |
| Which package provides a file | `yum provides <file>` OR `dnf provides <file>` |
| Clean cache | `yum clean all` OR `dnf clean all` |

---

### 🔹 RPM (Low-Level)
| Action | Command |
|--------|---------|
| Install .rpm | `rpm -ivh package.rpm` |
| Upgrade .rpm | `rpm -Uvh package.rpm` |
| Remove package | `rpm -e package_name` |
| Verify package | `rpm -V package_name` |
| Query package info | `rpm -qi package_name` |

---

### 🔹 Advanced YUM/DNF
| Action | Command |
|--------|---------|
| List enabled repositories | `yum repolist` OR `dnf repolist` |
| Enable a repository | `yum-config-manager --enable <repo>` |
| Disable a repository | `yum-config-manager --disable <repo>` |
| Install from a specific repo | `yum --enablerepo=<repo> install <package>` |
| Show history | `yum history` OR `dnf history` |
| Lock a package version | `yum versionlock <package>` (requires `yum-plugin-versionlock`) |

---

## ✅ Ubuntu / Debian (APT & DPKG)

### 🔹 Basic Commands
| Action | Command |
|--------|---------|
| Update package list | `sudo apt update` |
| Upgrade installed packages | `sudo apt upgrade` |
| Full upgrade (with removals) | `sudo apt full-upgrade` |
| Install a package | `sudo apt install <package>` |
| Remove a package | `sudo apt remove <package>` |
| Remove package + config | `sudo apt purge <package>` |
| Search for a package | `apt search <package>` |
| Show package info | `apt show <package>` |
| List installed packages | `dpkg -l` |
| Check if installed | `dpkg -s <package>` |
| Clean unused packages | `sudo apt autoremove` |
| Clean cache | `sudo apt clean` |

---

### 🔹 DPKG (Low-Level)
| Action | Command |
|--------|---------|
| Install .deb | `sudo dpkg -i package.deb` |
| Remove a package | `sudo dpkg -r package_name` |
| List installed packages | `dpkg -l` |
| Verify package files | `dpkg -V package_name` |

---

### 🔹 Advanced APT
| Action | Command |
|--------|---------|
| Hold package version | `sudo apt-mark hold <package>` |
| Unhold package version | `sudo apt-mark unhold <package>` |
| Show held packages | `apt-mark showhold` |
| Add a new repository | `sudo add-apt-repository ppa:<repo_name>` |
| Update GPG keys | `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys <key>` |

---

## ✅ Quick Comparison Table

| Task                | RHEL (YUM/DNF)      | Ubuntu (APT)         |
|---------------------|----------------------|-----------------------|
| Install package     | `yum install pkg`   | `apt install pkg`    |
| Remove package      | `yum remove pkg`    | `apt remove pkg`     |
| Update package list | `yum check-update`  | `apt update`         |
| Upgrade system      | `yum update`        | `apt upgrade`        |
| Search package      | `yum search pkg`    | `apt search pkg`     |
| Show info           | `yum info pkg`      | `apt show pkg`       |

---

## ✅ Extra Notes
- Always run `yum clean all` or `apt clean` after large updates to save disk space.
- For **local .rpm or .deb files**, use `rpm` or `dpkg` respectively.
- For dependency issues with dpkg, use:
  ```bash
  sudo apt --fix-broken install
  ```
---

### ✅ **Purpose of RPM**

* **`rpm`** is a **low-level package manager** for handling `.rpm` packages.
* It **only installs, removes, verifies, or queries** packages.
* It **does NOT resolve dependencies** automatically.
* It works directly on the package file (`.rpm`).

#### Example:

```bash
rpm -ivh package.rpm   # Install a package
rpm -e package_name    # Remove a package
rpm -q package_name    # Query if installed
```

---

### ✅ **Why do we need YUM or DNF if we have RPM?**

Because **`rpm` alone cannot handle dependencies**.

* Suppose you install `httpd.rpm`, and it needs `libxyz.rpm`.
* **`rpm` will fail** if `libxyz` is missing → You must install it manually.
* This is **dependency hell**.

**Solution:**

* **YUM** and **DNF** are **high-level package managers** built on top of RPM.
* They:

  * Automatically **resolve and install dependencies**.
  * Pull packages from **repositories**.
  * Handle updates, downgrades, and group installations.

---

### ✅ **Comparison**

| Tool    | Purpose                                                                               |
| ------- | ------------------------------------------------------------------------------------- |
| **rpm** | Low-level tool → Install/remove/query a single `.rpm` file (no dependency resolution) |
| **yum** | High-level manager → Resolves dependencies, works with repos (RHEL 7 & older)         |
| **dnf** | Next-gen YUM (faster, better dependency management, RHEL 8+)                          |

---

✅ **Summary:**

* **rpm** = Just a tool to handle `.rpm` files locally → No dependency management.
* **yum/dnf** = Smart managers that use RPM internally but also manage dependencies and repositories.

---


