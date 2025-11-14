#!/bin/bash
# Script to verify documentation deployment

echo "🔍 Verifying Documentation Deployment..."
echo ""

# Check if files exist locally
echo "1. Checking local files..."
if [ -f "docs/.nojekyll" ]; then
    echo "   ✅ .nojekyll exists"
else
    echo "   ❌ .nojekyll missing!"
fi

if [ -f "docs/_images/URBANSIM.png" ]; then
    echo "   ✅ URBANSIM.png exists locally"
    ls -lh docs/_images/URBANSIM.png | awk '{print "      Size: " $5}'
else
    echo "   ❌ URBANSIM.png missing locally!"
fi

# Check if files are tracked by git
echo ""
echo "2. Checking git tracking..."
if git ls-files docs/.nojekyll > /dev/null 2>&1; then
    echo "   ✅ .nojekyll is tracked by git"
else
    echo "   ❌ .nojekyll is NOT tracked by git!"
fi

if git ls-files docs/_images/URBANSIM.png > /dev/null 2>&1; then
    echo "   ✅ URBANSIM.png is tracked by git"
else
    echo "   ❌ URBANSIM.png is NOT tracked by git!"
fi

# Check if files are in latest commit
echo ""
echo "3. Checking if files are in latest commit..."
if git show HEAD:docs/.nojekyll > /dev/null 2>&1; then
    echo "   ✅ .nojekyll is in HEAD commit"
else
    echo "   ❌ .nojekyll is NOT in HEAD commit!"
fi

if git show HEAD:docs/_images/URBANSIM.png > /dev/null 2>&1; then
    echo "   ✅ URBANSIM.png is in HEAD commit"
else
    echo "   ❌ URBANSIM.png is NOT in HEAD commit!"
fi

# Check image path in HTML
echo ""
echo "4. Checking image path in HTML..."
if grep -q 'src="_images/URBANSIM.png"' docs/index.html; then
    echo "   ✅ Image path is relative: _images/URBANSIM.png"
else
    echo "   ❌ Image path not found or incorrect!"
fi

# Count images
echo ""
echo "5. Image statistics..."
IMAGE_COUNT=$(find docs/_images -name "*.png" -o -name "*.gif" | wc -l | tr -d ' ')
TRACKED_COUNT=$(git ls-files docs/_images/ | wc -l | tr -d ' ')
echo "   Total images in docs/_images/: $IMAGE_COUNT"
echo "   Images tracked by git: $TRACKED_COUNT"

if [ "$IMAGE_COUNT" -eq "$TRACKED_COUNT" ]; then
    echo "   ✅ All images are tracked"
else
    echo "   ⚠️  Some images may not be tracked"
fi

echo ""
echo "📋 Next Steps:"
echo "   1. Test direct URL: https://anonymoususeruseanonymousname.github.io/docs/_images/URBANSIM.png"
echo "   2. Verify GitHub Pages settings: Source = /docs folder"
echo "   3. Check browser console for 404 errors"
echo "   4. If needed, force GitHub Pages rebuild in repository settings"
echo ""

