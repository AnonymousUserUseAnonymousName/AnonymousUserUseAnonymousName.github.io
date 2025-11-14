# Documentation Deployment Instructions

## ✅ What Has Been Done

1. **Documentation Built**: Your Sphinx documentation is already built in `documentation/_build/current/`
2. **Documentation Deployed**: Copied to `docs/` folder in the repository root
3. **Link Page Created**: `urbanverse_docs.html` created to redirect to the documentation

## 📁 File Structure

```
your-repo/
├── index.html                    # Main UrbanVerse page
├── urbanverse_docs.html          # Redirect page to documentation
├── docs/                         # Deployed documentation (NEW)
│   ├── index.html               # Documentation homepage
│   ├── source/                  # Documentation pages
│   └── ...
└── documentation/                # Source documentation
    ├── source/                  # Source RST/MD files
    ├── _build/current/          # Built HTML files
    └── ...
```

## 🌐 Access Your Documentation

After pushing to GitHub, your documentation will be available at:

- **Direct link**: `https://yourusername.github.io/docs/`
- **Redirect page**: `https://yourusername.github.io/urbanverse_docs.html`

## 🚀 Deployment Steps

### Step 1: Commit the Changes

```bash
# Add the new files
git add docs/
git add urbanverse_docs.html

# Commit
git commit -m "Deploy documentation to GitHub Pages"

# Push to GitHub
git push origin main
```

### Step 2: Verify on GitHub

1. Go to your repository on GitHub
2. Check that `docs/` folder and `urbanverse_docs.html` are present
3. Wait a few minutes for GitHub Pages to update
4. Visit `https://yourusername.github.io/urbanverse_docs.html`

## 🔄 Updating Documentation

When you update the documentation source files:

### Option 1: Rebuild and Redeploy Manually

```bash
# 1. Navigate to documentation folder
cd documentation

# 2. Build the documentation (if you have Python/Sphinx installed)
# Create virtual environment (first time only)
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies (first time only)
pip install -r requirements.txt

# Build documentation
make current-docs

# 3. Deploy to docs/ folder (from repository root)
cd ..
rm -rf docs/*
cp -r documentation/_build/current/* docs/

# 4. Commit and push
git add docs/
git commit -m "Update documentation"
git push
```

### Option 2: Use Pre-built Documentation

If the documentation in `documentation/_build/current/` is already up-to-date:

```bash
# Just copy and commit
rm -rf docs/*
cp -r documentation/_build/current/* docs/
git add docs/
git commit -m "Update documentation"
git push
```

## 📝 Adding Documentation Link to Main Page

If you want to add a link to the documentation from your main `index.html` page, you can add this to your navigation:

```html
<a href="./urbanverse_docs.html" class="button toc-btn">Documentation</a>
```

Or link directly:

```html
<a href="./docs/index.html" class="button toc-btn">Documentation</a>
```

## ✅ Verification Checklist

- [x] Documentation built in `documentation/_build/current/`
- [x] Documentation copied to `docs/` folder
- [x] `urbanverse_docs.html` redirect page created
- [ ] Changes committed to git
- [ ] Changes pushed to GitHub
- [ ] GitHub Pages updated (wait 1-5 minutes)
- [ ] Documentation accessible at `https://yourusername.github.io/docs/`

## 🐛 Troubleshooting

### Documentation not showing after push

1. **Check GitHub Pages settings**:
   - Go to repository Settings → Pages
   - Ensure source is set to your branch (usually `main` or `master`)
   - Ensure folder is set to `/ (root)` or `/docs`

2. **Verify files are committed**:
   ```bash
   git status
   git ls-files docs/
   ```

3. **Check file paths**:
   - Ensure `docs/index.html` exists
   - Ensure `urbanverse_docs.html` exists in root

4. **Wait for GitHub Pages**:
   - GitHub Pages can take 1-5 minutes to update
   - Check Actions tab for deployment status

### Links not working

- Ensure paths are relative (start with `./` or just the path)
- Check that `docs/` folder is in the repository root
- Verify `urbanverse_docs.html` is in the repository root

## 📚 Documentation Content

Your documentation includes:
- Setup & Installation guides
- Overview (simulation, environments, configuration)
- Reinforcement Learning documentation
- Developer guides
- References (assets, licenses, changelog)

All content is accessible through the documentation site at `./docs/index.html`.

