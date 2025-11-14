# GitHub Pages: Serving Both Root and Docs Folder

## The Problem

If you set GitHub Pages source to `/docs`:
- ✅ `docs/index.html` will work
- ❌ Root `index.html` will NOT work

If you set GitHub Pages source to `/ (root)`:
- ✅ Root `index.html` will work
- ✅ `docs/index.html` should also work (as a subdirectory)
- ⚠️ But Jekyll might process the `docs/` folder

## Solution: Use Root Source with `.nojekyll`

**Recommended approach:**

1. **Set GitHub Pages source to `/ (root)`** (not `/docs`)
   - This allows both your main page and docs to work

2. **Keep `.nojekyll` in `docs/` folder**
   - This tells Jekyll to skip processing the `docs/` folder
   - Files in `docs/_images/` and `docs/_static/` will be served correctly

3. **How it works:**
   - Root `index.html` → `https://anonymoususeruseanonymousname.github.io/`
   - Docs `index.html` → `https://anonymoususeruseanonymousname.github.io/docs/`
   - Both work simultaneously!

## Why This Works

- GitHub Pages serves from root by default
- The `.nojekyll` file in `docs/` prevents Jekyll from processing that folder
- Jekyll normally ignores folders starting with `_`, but `.nojekyll` ensures all files are served
- Both root and subdirectories are accessible

## Alternative: Use GitHub Actions (Advanced)

If you need more control, you can use GitHub Actions to:
- Build docs separately
- Deploy to different locations
- Have more granular control

But for most cases, using root source with `.nojekyll` is the simplest solution.

## Current Status

Your setup should work with:
- **Source:** `/ (root)`
- **`.nojekyll`** in `docs/` folder ✅ (already done)
- **Relative paths** in docs ✅ (already done)

## Verification

After setting source to root, test:
1. Main page: `https://anonymoususeruseanonymousname.github.io/` ✅
2. Docs page: `https://anonymoususeruseanonymousname.github.io/docs/` ✅
3. Docs image: `https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png` ✅

