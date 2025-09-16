### **1. Git Configure**

Before working with Git, configure your identity and editor.

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global core.editor "vim"      # optional
git config --list                          # check configs
```

---

### **2. Working Directory**

* This is where your actual project files are.
* Files here can be:

  * **Untracked**: New files not added to Git yet.
  * **Modified**: Changed files after last commit.

**Check status:**

```bash
git status
```

---

### **3. Staging Area (Index)**

* A temporary area where you **prepare changes before committing**.
* You decide what to include in the next commit.

```bash
git add filename        # Add specific file
git add .               # Add all changes
git reset filename      # Remove from staging
```

---

### **4. Local Repository**

* Where committed changes are stored permanently on your machine.
* After staging, commit changes:

```bash
git commit -m "Your commit message"
git log                # View commit history
git log --oneline      # Compact view
```

---

### **5. Stash**

* Save uncommitted changes temporarily without committing.
* Useful when switching branches.

```bash
git stash              # Save changes
git stash list         # View stashes
git stash apply        # Apply latest stash (keep in stash list)
git stash pop          # Apply and remove from stash list
```

---

### **6. Basic Commands Recap**

```bash
git status             # Show working dir and staging area status
git diff               # Show changes not staged
git diff --staged      # Show staged changes
git add <file>         # Stage changes
git commit -m "msg"    # Commit to local repo
git log                # Show commit history
```

---

### **7. Pull & Push (Remote Repository)**

* To collaborate, you use a **remote repository** (e.g., GitHub).

**Add remote (one-time):**

```bash
git remote add origin https://github.com/user/repo.git
git remote -v          # Verify remotes
```

**Push to remote:**

```bash
git push origin main       # Push changes
git push -u origin main    # First time (sets upstream)
```

**Pull from remote:**

```bash
git pull origin main       # Fetch + merge changes
```

---