## 1. Git Introduction

### Git

* **Git:** Distributed Version Control System (DVCS) to **track changes in code**, collaborate, and manage multiple versions.
* **Key Feature:** Each developer has a **full copy of the repository** locally.

---

### VCS vs DVCS

| Feature            | VCS (Centralized)      | DVCS (Git)                    |
| ------------------ | ---------------------- | ----------------------------- |
| Repository         | Single central repo    | Full copy for every developer |
| Network dependency | Must connect to server | Can work offline              |
| History            | Stored on server       | Stored locally + server       |
| Collaboration      | Push/Pull to server    | Push/Pull + local commits     |
| Examples           | SVN, CVS               | Git, Mercurial                |

**Easy way to say:**

* **VCS = central repo, always online**
* **DVCS = local + central, can work offline**

---
## 2. Git Basic Configuration

### Purpose

* Set up **user identity, editor, and preferences** for commits and Git operations.

### Commands

```bash
# Set username
git config --global user.name "Your Name"

# Set email
git config --global user.email "you@example.com"

# Set default editor
git config --global core.editor "vim"

# View current config
git config --list
```

**Key Points:**

* `--global` → applies for all repos on your machine
* Without `--global` → applies only to the current repository
* Required for **commits to show correct author info**

---

**Easy way to explain in interview:**

* “Git config sets **username, email, and editor**, so commits are tracked with proper identity.”

---

## 2. Git Working Areas

Git has **three main areas**:

1. **Working Directory (WD)** – Local files you can edit.
2. **Staging Area / Index** – Files added via `git add`, ready to commit.
3. **Repository (.git)** – Stores committed snapshots and history.

**ASCII Visual:**

```
Working Directory
   (edit files)
        |
        v
  Staging Area (git add)
        |
        v
   Repository (git commit)
        |
        v
   Remote Repo (git push)
```

---

## 2a. Git Basic Commands

```bash
git init              # Initialize repo
git clone <url>       # Clone remote repo
git status            # Show changes
git add <file>        # Stage file
git commit -m "msg"   # Commit staged changes
git push              # Push commits to remote
git pull              # Fetch & merge from remote
git log               # View commit history
```

**Easy explanation:**

* `add → commit → push` is the main workflow

---

## 2b. Git Reset

* **Purpose:** Undo commits or staged changes.
* **Types:**

  * `--soft` → Undo commit, keep changes staged
  * `--mixed` → Undo commit, unstage changes (default)
  * `--hard` → Undo commit **and discard changes**

**Example:**

```bash
git reset --soft HEAD~1   # Undo last commit, keep changes staged
git reset --hard HEAD~1   # Undo last commit, discard changes
```

---

## 2c. Git Stash

* **Purpose:** Temporarily save uncommitted changes to switch branches or clean working directory.

**Commands:**

```bash
git stash         # Save changes
git stash list    # View stashes
git stash pop     # Apply and remove stash
git stash apply   # Apply without removing stash
```

**Easy explanation:**

* “Stash lets you **pause work**, switch branches, and continue later.”
---

```
Working Directory (edit files)
        |
        v
   git add (stage)
        |
        v
   Staging Area / Index
        |
        v
   git commit
        |
        v
   Repository (.git)
        |
        v
   git push → Remote Repo
```

### Reset Flow

```
Undo last commit or changes
----------------------------
Repository (.git)
   ^        ^
   |        |
git reset --soft  # undo commit, keep staged
git reset --hard  # undo commit, discard changes
```

### Stash Flow

```
Working Directory (changes not ready to commit)
        |
   git stash save   ← Temporarily save changes
        |
        v
   Switch Branch / Work on something else
        |
        v
   git stash pop    ← Apply saved changes back
```

**Memory Tip for Interviews:**

* **Working Dir → Stage → Commit → Push** = normal workflow
* **Reset** = undo commits/changes
* **Stash** = temporarily save changes

---
