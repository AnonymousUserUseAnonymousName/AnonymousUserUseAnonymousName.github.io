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
# Remove old contents (but keep structure)
rm -rf docs/*

# Copy built documentation first
echo "📄 Copying documentation files..."
cp -r documentation/_build/current/* docs/

# Rename documentation index.html to urbanverse_documentation.html
echo "📝 Renaming documentation index to urbanverse_documentation.html..."
if [ -f "docs/index.html" ]; then
    mv docs/index.html docs/urbanverse_documentation.html
fi

# Copy original index.html as the main landing page
echo "📄 Copying original index.html as landing page..."
cp index.html docs/index.html

# Copy static folder
echo "📦 Copying static assets..."
cp -r static docs/static

# Copy UrbanVerse-100K_Interactive_Distribution.html if it exists
if [ -f "UrbanVerse-100K_Interactive_Distribution.html" ]; then
    echo "📄 Copying UrbanVerse-100K_Interactive_Distribution.html..."
    cp UrbanVerse-100K_Interactive_Distribution.html docs/
fi

# Create .nojekyll file for GitHub Pages (allows folders starting with _)
echo "📝 Creating .nojekyll file..."
touch docs/.nojekyll

# Fix paths in documentation HTML files
echo "🔧 Fixing paths for GitHub Pages..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    # Update all references from index.html to urbanverse_documentation.html in documentation files
    find docs/ -name "*.html" -type f ! -name "index.html" ! -name "UrbanVerse-100K_Interactive_Distribution.html" -exec sed -i '' \
        -e 's|href="index\.html|href="urbanverse_documentation.html|g' \
        -e 's|href="\./index\.html|href="./urbanverse_documentation.html|g' \
        -e 's|href="/index\.html|href="/urbanverse_documentation.html|g' \
        -e 's|href="/Users/[^"]*fontawesome-free/css/all.min.css"|href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"|g' \
        -e 's|src="/Users/[^"]*fontawesome-free/js/all.min.js"|src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"|g' \
        {} \; 2>/dev/null || true
    
    # Fix search.html and genindex.html references
    find docs/ -name "search.html" -o -name "genindex.html" | while read file; do
        sed -i '' \
            -e 's|action="index\.html"|action="urbanverse_documentation.html"|g' \
            -e 's|href="index\.html|href="urbanverse_documentation.html|g' \
            "$file" 2>/dev/null || true
    done
else
    # Linux
    find docs/ -name "*.html" -type f ! -name "index.html" ! -name "UrbanVerse-100K_Interactive_Distribution.html" -exec sed -i \
        -e 's|href="index\.html|href="urbanverse_documentation.html|g' \
        -e 's|href="\./index\.html|href="./urbanverse_documentation.html|g' \
        -e 's|href="/index\.html|href="/urbanverse_documentation.html|g' \
        -e 's|href="/Users/[^"]*fontawesome-free/css/all.min.css"|href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"|g' \
        -e 's|src="/Users/[^"]*fontawesome-free/js/all.min.js"|src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"|g' \
        {} \; 2>/dev/null || true
    
    find docs/ -name "search.html" -o -name "genindex.html" | while read file; do
        sed -i \
            -e 's|action="index\.html"|action="urbanverse_documentation.html"|g' \
            -e 's|href="index\.html|href="urbanverse_documentation.html|g' \
            "$file" 2>/dev/null || true
    done
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

echo "✅ Build completed successfully!"
echo ""
echo "📁 Output structure in docs/:"
echo "   - index.html (original UrbanVerse landing page)"
echo "   - urbanverse_documentation.html (Sphinx documentation)"
echo "   - static/ (all static assets)"
echo "   - UrbanVerse-100K_Interactive_Distribution.html"
echo "   - _images/, _static/ (documentation assets)"
echo ""
echo "🌐 Next steps:"
echo "   1. Review changes: git status"
echo "   2. Commit: git add docs/ documentation/ index.html"
echo "   3. Push: git commit -m 'Update documentation and landing page' && git push"
echo "   4. Set GitHub Pages source to '/docs' folder in repository settings"
echo ""
echo "   Your pages will be available at:"
echo "   - Landing page: https://anonymoususeruseanonymousname.github.io/"
echo "   - Documentation: https://anonymoususeruseanonymousname.github.io/urbanverse_documentation.html"

