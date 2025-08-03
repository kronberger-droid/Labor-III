#!/bin/bash

# Script to combine Labor-III-* repositories using git subtree
# Make sure you're in the target repository directory before running this

set -e  # Exit on any error

# GitHub username
GITHUB_USER="kronberger-droid"

# Array of Labor-III repositories (without the prefix)
LABOR_REPOS=(
    "Labor-III-ESR"
    "Labor-III-EModul" 
    "Labor-III-Roentgen"
    "Labor-III-Wp"
    "Labor-III-Co"
)

echo "🔧 Starting to combine Labor-III repositories..."
echo "Current directory: $(pwd)"
echo "Target repositories: ${LABOR_REPOS[@]}"
echo ""

# Confirm before proceeding
read -p "Are you in the correct target repository? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted. Please navigate to your target repository first."
    exit 1
fi

for repo in "${LABOR_REPOS[@]}"; do
    echo "📥 Adding $repo as subtree..."
    
    # Create folder name (remove Labor-III- prefix for cleaner structure)
    folder_name=$(echo "$repo" | sed 's/Labor-III-//')
    
    # Add the repository as a subtree
    if git subtree add --prefix="$folder_name" \
        "https://github.com/$GITHUB_USER/$repo.git" \
        main --squash; then
        echo "✅ Successfully added $repo to folder: $folder_name"
    else
        echo "⚠️  Failed to add $repo (might not have 'main' branch, trying 'master'...)"
        
        # Try with master branch if main fails
        if git subtree add --prefix="$folder_name" \
            "https://github.com/$GITHUB_USER/$repo.git" \
            master --squash; then
            echo "✅ Successfully added $repo to folder: $folder_name (using master branch)"
        else
            echo "❌ Failed to add $repo with both main and master branches"
        fi
    fi
    
    echo ""
done

echo "🎉 Repository combination complete!"
echo ""
echo "📝 Next steps:"
echo "  - Review the combined structure with: ls -la"
echo "  - Commit the changes: git commit -m 'Combine Labor-III repositories'"
echo "  - Push to remote: git push origin main"
echo ""
echo "🔄 To update a subtree later, use:"
echo "  git subtree pull --prefix=<folder-name> https://github.com/$GITHUB_USER/Labor-III-<name>.git main --squash"
