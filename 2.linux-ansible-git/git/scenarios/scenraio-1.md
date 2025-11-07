### ❓ Question

**During a project, you accidentally pushed your `argocd` and `helm-instana` folders to GitHub, but they showed up with an arrow icon and appeared empty when cloning the repo. What caused this issue and how did you resolve it?**

---

### ✅ Answer

This happened because the folders were accidentally added as **Git submodules** instead of regular folders. Git interpreted them as **external linked repositories**, which is why GitHub showed an **arrow icon**, and the folders appeared **empty after cloning**.

To fix it, I removed them as submodules and re-added them as normal folders using the following commands:

```bash
git rm --cached argocd
git rm --cached helm-instana

git add argocd
git add helm-instana

git commit -m "Fixed: added folders as normal instead of submodule"
git push origin main
```