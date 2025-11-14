# GitHub Pages 404 Error Troubleshooting

## Issue: Images showing 404 on GitHub Pages

The files are tracked in git, but GitHub Pages is returning 404 errors.

## Possible Causes & Solutions

### 1. Files Not Pushed to Remote

**Check:**
```bash
git log --oneline -5
git status
```

**Solution:**
```bash
# Make sure all files are committed
git add docs/
git commit -m "Add documentation images"
git push origin main
```

### 2. GitHub Pages Not Enabled or Wrong Source

**Check GitHub Settings:**
1. Go to your repository on GitHub
2. Settings → Pages
3. Source should be set to:
   - **Branch:** `main` (or `master`)
   - **Folder:** `/ (root)` or `/docs`

**If using `/docs` folder:**
- Make sure `docs/` folder is in the root of your repository
- Make sure `docs/index.html` exists

### 3. Case Sensitivity Issue

GitHub Pages is case-sensitive. Check:
- File name: `URBANSIM.png` (all caps)
- URL: `docs/_images/URBANSIM.png` (should match exactly)

**Verify:**
```bash
ls -la docs/_images/URBANSIM.png
# Should show the file exists
```

### 4. GitHub Pages Cache

GitHub Pages can take a few minutes to update. Try:
1. Wait 5-10 minutes after pushing
2. Hard refresh: `Ctrl+F5` or `Cmd+Shift+R`
3. Clear browser cache

### 5. Private Repository Limitation

**GitHub Pages with Private Repos:**
- ✅ Works with GitHub Free (public repos)
- ✅ Works with GitHub Pro/Team/Enterprise (private repos)
- ❌ Does NOT work with GitHub Free private repos (legacy)

**Check your plan:**
- If you have GitHub Free and the repo is private, you need to either:
  - Make the repo public, OR
  - Upgrade to GitHub Pro/Team

**Alternative for Free Private Repos:**
- Use GitHub Actions to deploy to a different hosting service
- Use Netlify, Vercel, or similar (they support private repos)

### 6. File Size Limits

Large files might not be served properly. Check:
```bash
ls -lh docs/_images/URBANSIM.png
ls -lh docs/_images/teaser.gif
```

If files are very large (>100MB), consider:
- Compressing images
- Using Git LFS for large files

### 7. Verify Files Are Actually on GitHub

**Check on GitHub:**
1. Go to: `https://github.com/yourusername/yourrepo/tree/main/docs/_images`
2. Verify `URBANSIM.png` is visible
3. Click on it to see if it loads

If the file is not visible on GitHub, it wasn't pushed.

## Quick Diagnostic Commands

```bash
# 1. Check if files exist locally
ls -la docs/_images/URBANSIM.png

# 2. Check if files are tracked by git
git ls-files docs/_images/URBANSIM.png

# 3. Check if files are committed
git log --oneline --all -- docs/_images/URBANSIM.png

# 4. Check if there are uncommitted changes
git status

# 5. Check remote repository
git remote -v

# 6. Verify what's actually in docs/
find docs/ -name "*.png" -o -name "*.gif" | head -20
```

## Most Likely Solution

Based on your situation, the most likely issues are:

1. **Files not pushed to remote** - Run `git push origin main`
2. **GitHub Pages source folder** - Make sure it's set to `/docs` in Settings → Pages
3. **Private repo limitation** - If you're on GitHub Free, private repos don't support Pages

## Next Steps

1. **Verify files are pushed:**
   ```bash
   git push origin main
   ```

2. **Check GitHub Pages settings:**
   - Repository → Settings → Pages
   - Source: `main` branch, `/docs` folder

3. **Wait 5-10 minutes** for GitHub Pages to rebuild

4. **Test the URL directly:**
   ```
   https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png
   ```

5. **If still not working**, check if your GitHub plan supports Pages for private repos.

