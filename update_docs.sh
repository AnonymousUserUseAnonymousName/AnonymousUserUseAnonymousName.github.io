#!/bin/bash
# Quick script to rebuild and deploy documentation

set -e  # Exit on error

echo "🔄 Updating documentation..."

# Navigate to documentation directory
cd "$(dirname "$0")/documentation"

# Check if virtual environment exists
if [ -d "venv" ]; then
    echo "🔌 Activating virtual environment..."
    source venv/bin/activate
fi

# Rebuild documentation
echo "🏗️  Rebuilding documentation from source files..."
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
rm -rf docs/*
cp -r documentation/_build/current/* docs/

echo "✅ Documentation updated successfully!"
echo ""
echo "📁 Updated files are in: docs/"
echo ""
echo "Next steps:"
echo "  1. Review changes: git status"
echo "  2. Commit: git add documentation/source/ docs/"
echo "  3. Push: git commit -m 'Update documentation' && git push"

