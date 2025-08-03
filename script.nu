#!/usr/bin/env nu

# Script to combine Labor-III-* repositories using git subtree
# Make sure you're in the target repository directory before running this

# GitHub username
let github_user = "kronberger-droid"

# Array of Labor-III repositories
let labor_repos = [
    "Labor-III-ESR"
    "Labor-III-EModul" 
    "Labor-III-Roentgen"
    "Labor-III-Wp"
    "Labor-III-Co"
]

print "🔧 Starting to combine Labor-III repositories..."
print $"Current directory: (pwd)"
print $"Target repositories: ($labor_repos | str join ', ')"
print ""

# Confirm before proceeding
let response = (input "Are you in the correct target repository? (y/N): ")
if not ($response | str downcase | str starts-with "y") {
    print "❌ Aborted. Please navigate to your target repository first."
    exit 1
}

for repo in $labor_repos {
    print $"📥 Adding ($repo) as subtree..."
    
    # Create folder name (remove Labor-III- prefix for cleaner structure)
    let folder_name = ($repo | str replace "Labor-III-" "")
    
    # Check if folder already exists
    if ($folder_name | path exists) {
        print $"⏭️  Skipping ($repo) - folder ($folder_name) already exists"
        continue
    }
    
    # Try to add the repository as a subtree with main branch
    try {
        ^git subtree add $"--prefix=($folder_name)" $"https://github.com/($github_user)/($repo).git" main --squash
        print $"✅ Successfully added ($repo) to folder: ($folder_name)"
    } catch {
        print $"⚠️  Failed to add ($repo) - might not have main branch, trying master..."
        
        # Try with master branch if main fails
        try {
            ^git subtree add $"--prefix=($folder_name)" $"https://github.com/($github_user)/($repo).git" master --squash
            print $"✅ Successfully added ($repo) to folder: ($folder_name) using master branch"
        } catch {
            print $"❌ Failed to add ($repo) with both main and master branches"
        }
    }
    
    print ""
}

print "🎉 Repository combination complete!"
print ""
print "📝 Next steps:"
print "  - Review the combined structure with: ls -la"
print "  - Commit the changes: git commit -m 'Combine Labor-III repositories'"
print "  - Push to remote: git push origin main"
print ""
print "🔄 To update a subtree later, use:"
print $"  git subtree pull --prefix=<folder-name> https://github.com/($github_user)/Labor-III-<repo-name>.git main --squash"
