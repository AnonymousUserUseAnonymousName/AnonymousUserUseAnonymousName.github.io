#!/bin/bash
# Build Sphinx documentation and deploy to docs/ folder for GitHub Pages

set -e  # Exit on error

echo "🔄 Building documentation..."

# Navigate to documentation directory
cd "$(dirname "$0")/documentation"

# Check if virtual environment exists
if [ -d "venv" ]; then
    echo "🔌 Activating virtual environment..."
    source venv/bin/activate
fi

# Build documentation
echo "🏗️  Building documentation from source files..."
make current-docs

# Check if build was successful
if [ ! -f "_build/current/index.html" ]; then
    echo "❌ Build failed! index.html not found."
    exit 1
fi

# Go back to repository root
cd ..

# Deploy to docs/ folder
echo "📦 Deploying to docs/ folder..."
# Create docs directory if it doesn't exist
mkdir -p docs
# Remove old contents
rm -rf docs/*
# Copy built documentation
cp -r documentation/_build/current/* docs/

# Create .nojekyll file for GitHub Pages (allows folders starting with _)
echo "📝 Creating .nojekyll file..."
touch docs/.nojekyll

# Fix absolute paths in HTML files (if any)
echo "🔧 Fixing paths for GitHub Pages..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    find docs/ -name "*.html" -type f -exec sed -i '' \
        -e 's|href="/Users/[^"]*fontawesome-free/css/all.min.css"|href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"|g' \
        -e 's|src="/Users/[^"]*fontawesome-free/js/all.min.js"|src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"|g' \
        {} \; 2>/dev/null || true
else
    # Linux
    find docs/ -name "*.html" -type f -exec sed -i \
        -e 's|href="/Users/[^"]*fontawesome-free/css/all.min.css"|href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"|g' \
        -e 's|src="/Users/[^"]*fontawesome-free/js/all.min.js"|src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"|g' \
        {} \; 2>/dev/null || true
fi

# Remove canonical URLs with absolute paths (they can cause issues)
if [[ "$OSTYPE" == "darwin"* ]]; then
    find docs/ -name "*.html" -type f -exec sed -i '' \
        -e 's|<link rel="canonical" href="https://[^"]*github\.io[^"]*" />||g' \
        {} \; 2>/dev/null || true
else
    find docs/ -name "*.html" -type f -exec sed -i \
        -e 's|<link rel="canonical" href="https://[^"]*github\.io[^"]*" />||g' \
        {} \; 2>/dev/null || true
fi

echo "✅ Documentation built successfully!"
echo ""
echo "📁 Output files are in: docs/"
echo ""
echo "🌐 Next steps:"
echo "   1. Review changes: git status"
echo "   2. Commit: git add docs/ documentation/"
echo "   3. Push: git commit -m 'Update documentation' && git push"
echo "   4. Set GitHub Pages source to '/docs' folder in repository settings"
echo ""
echo "   Your documentation will be available at:"
echo "   https://anonymoususeruseanonymousname.github.io/"

