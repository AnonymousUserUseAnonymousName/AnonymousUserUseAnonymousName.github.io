# Testing Image Access on GitHub Pages

## The Issue

Images work on the main page (`index.html`) but not in the documentation (`docs/index.html`).

## Test Direct Image URLs

Try accessing these URLs directly in your browser:

1. **Main page image (works):**
   ```
   https://anonymoususeruseanonymousname.github.io/static/urbanverse_images/sidewalk_pbrs.png
   ```

2. **Documentation image (should work):**
   ```
   https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png
   ```

## If the direct URL works but images don't show in the page:

The issue is likely with **relative path resolution**. When viewing `docs/index.html`, the browser resolves `_images/URBANSIM.png` relative to the current page URL.

**Expected behavior:**
- Page URL: `https://anonymoususeruseanonymousname.github.io/docs/index.html`
- Image path: `_images/URBANSIM.png`
- Resolved URL: `https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png` ✅

## Possible Solutions

### Solution 1: Verify GitHub Pages Settings

1. Go to: `https://github.com/AnonymousUserUseAnonymousName/AnonymousUserUseAnonymousName.github.io/settings/pages`
2. Ensure:
   - **Source**: `Deploy from a branch`
   - **Branch**: `main`
   - **Folder**: `/docs` ← **Critical!**

### Solution 2: Check Browser Console

Open the documentation page and check the browser console (F12) for 404 errors. This will show the exact URLs the browser is trying to load.

### Solution 3: Force GitHub Pages Rebuild

Sometimes GitHub Pages needs a manual rebuild:

1. Go to: `https://github.com/AnonymousUserUseAnonymousName/AnonymousUserUseAnonymousName.github.io/settings/pages`
2. Click "Save" (even if nothing changed) to trigger a rebuild
3. Wait 5-10 minutes

### Solution 4: Verify Files Are Actually on GitHub

Visit this URL to see if the file exists:
```
https://github.com/AnonymousUserUseAnonymousName/AnonymousUserUseAnonymousName.github.io/tree/main/docs/_images
```

You should see `URBANSIM.png` in the file list.

## Next Steps

1. **Test the direct image URL** - Does `https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png` work?
2. **Check browser console** - What errors do you see?
3. **Verify GitHub Pages settings** - Is the source folder set to `/docs`?
4. **Check file on GitHub** - Is the file visible in the repository?

