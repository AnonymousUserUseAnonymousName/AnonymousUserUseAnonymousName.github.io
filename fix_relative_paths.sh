#!/bin/bash
# Script to convert all absolute paths to relative paths in HTML files

set -e

DOCS_DIR="docs"

echo "🔧 Converting absolute paths to relative paths..."

# Find all HTML files
find "$DOCS_DIR" -name "*.html" -type f | while read -r file; do
    echo "Processing: $file"
    
    # Get the depth of the file (how many directories deep)
    depth=$(echo "$file" | tr -cd '/' | wc -c)
    depth=$((depth - 1))  # Subtract 1 for docs/ itself
    
    # Create relative path prefix (../ for each level)
    if [ "$depth" -gt 0 ]; then
        prefix=$(printf '../%.0s' $(seq 1 $depth))
    else
        prefix="./"
    fi
    
    # Fix canonical URLs - remove absolute URLs, keep relative
    sed -i '' "s|<link rel=\"canonical\" href=\"https://[^\"]*github\.io[^\"]*\" />||g" "$file" 2>/dev/null || \
    sed -i "s|<link rel=\"canonical\" href=\"https://[^\"]*github\.io[^\"]*\" />||g" "$file"
    
    # Fix any remaining absolute paths that start with /docs/ or /anonymoususeruseanonymousname.github.io/
    sed -i '' "s|href=\"/docs/|href=\"./|g" "$file" 2>/dev/null || \
    sed -i "s|href=\"/docs/|href=\"./|g" "$file"
    
    sed -i '' "s|src=\"/docs/|src=\"./|g" "$file" 2>/dev/null || \
    sed -i "s|src=\"/docs/|src=\"./|g" "$file"
    
    sed -i '' "s|href=\"/anonymoususeruseanonymousname\.github\.io/|href=\"./|g" "$file" 2>/dev/null || \
    sed -i "s|href=\"/anonymoususeruseanonymousname\.github\.io/|href=\"./|g" "$file"
    
    sed -i '' "s|src=\"/anonymoususeruseanonymousname\.github\.io/|src=\"./|g" "$file" 2>/dev/null || \
    sed -i "s|src=\"/anonymoususeruseanonymousname\.github\.io/|src=\"./|g" "$file"
done

echo "✅ Path conversion complete!"

