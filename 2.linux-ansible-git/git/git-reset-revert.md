### **What is `git reset`?**

`git reset` is a Git command used to **undo changes** in your repository. It can move the current branch pointer to a previous commit and optionally **change the staging area or working directory**.

Think of it as a way to "rewind" your repository to a previous state.

---

### **Three main types of `git reset`**

1. **Soft reset (`--soft`)**

   * Moves the branch pointer to a previous commit.
   * **Keeps your changes staged** (in the index).
   * Use case: You want to undo a commit but keep the changes ready to commit again.

   ```bash
   git reset --soft <commit-hash>
   ```

2. **Mixed reset (`--mixed`)** *(default)*

   * Moves the branch pointer to a previous commit.
   * **Unstages your changes** but keeps them in your working directory.
   * Use case: You want to undo a commit and unstage changes to edit them before committing again.

   ```bash
   git reset --mixed <commit-hash>
   # or simply
   git reset <commit-hash>
   ```

3. **Hard reset (`--hard`)**

   * Moves the branch pointer to a previous commit.
   * **Deletes all changes** in staging and working directory.
   * Use case: You want to completely discard recent commits and changes.

   ```bash
   git reset --hard <commit-hash>
   ```

---

### **Example**

Imagine this commit history:

```
A - B - C - D  (HEAD -> main)
```

* `HEAD` points to commit `D`.
* You realize you want to undo the last commit (`D`).

**Soft reset example:**

```bash
git reset --soft C
```

* Branch moves to `C`.
* Changes from `D` are still staged.

**Mixed reset example:**

```bash
git reset C
```

* Branch moves to `C`.
* Changes from `D` are unstaged but still in the files.

**Hard reset example:**

```bash
git reset --hard C
```

* Branch moves to `C`.
* Changes from `D` are completely gone from staging and files.

---

### **What is `git revert`?**

`git revert` is a Git command used to **undo a commit by creating a new commit** that reverses the changes of the original commit.

* **Important:** Unlike `git reset`, it **does not remove history**.
* Safe for shared branches because it doesn’t rewrite commits.

---

### **How it works**

Imagine your commit history:

```
A - B - C - D  (HEAD -> main)
```

* You realize commit `C` introduced a bug.
* Using `git revert` on `C` will create a **new commit** that undoes the changes in `C`:

```bash
git revert C
```

After revert:

```
A - B - C - D - E  (HEAD -> main)
```

* Commit `E` undoes the changes made in `C`.
* Commits `C` and `D` still exist in history.

---

### **Key points**

* `git revert` is **safe for public/shared branches**.
* You can revert **multiple commits**:

```bash
git revert C D
```

* If a **conflict occurs**, Git will pause and ask you to resolve it, then you continue with:

```bash
git revert --continue
```

---

### **Quick Example**

1. Make some commits:

```bash
echo "Hello" > file.txt
git add file.txt
git commit -m "Add file.txt"

echo "World" >> file.txt
git add file.txt
git commit -m "Update file.txt"
```

2. Revert the second commit:

```bash
git revert HEAD
```

* This creates a **new commit** that removes the "World" addition, but the first commit "Add file.txt" stays.

---

✅ **Summary:**

* `git reset` → moves branch pointer, can remove commits (rewrites history)
* `git revert` → adds a new commit to **undo changes** safely without rewriting history

---

**Easy way to say in interview:**

* **Revert = safe undo with new commit**
* **Reset = local undo, rewrites history, risky for shared branches**