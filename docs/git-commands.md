# Git Commands Reference

## Daily Workflow Commands

### Checking Status
- `git status` - See what files changed
- `git log` - See commit history
- `git log --oneline` - Compact commit history

### Making Changes
- `git add <file>` - Stage a specific file
- `git add .` - Stage all changes in current directory
- `git commit -m "message"` - Commit staged changes
- `git push` - Push commits to GitHub
- `git pull` - Get latest changes from GitHub

### Branching (will practice Day 3)
- `git branch` - List all branches
- `git branch <name>` - Create new branch
- `git checkout <name>` - Switch to branch
- `git checkout -b <name>` - Create and switch to new branch
- `git merge <branch>` - Merge branch into current branch

## Good Commit Message Examples
- ✅ "Add project folder structure"
- ✅ "Create .gitignore for Azure project"
- ✅ "Add Day 2 documentation"
- ❌ "updates"
- ❌ "changes"
- ❌ "stuff"

## Notes
- Commit messages should be clear and descriptive
- Commit often - small commits are better than big ones
- Always pull before you push when working with others