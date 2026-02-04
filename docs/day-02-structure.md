# Day 2 Summary - February 3, 2025

## What I Accomplished Today
Established project structure, implemented version control best practices with .gitignore, and created documentation workflow.

## Tasks Completed

### 1. Created Project Folder Structure
Created organized directory structure for different project components:
```bash
mkdir bicep-modules
mkdir pipelines
mkdir scripts
mkdir docs

# Created subfolders for Bicep modules
mkdir bicep-modules\storage
mkdir bicep-modules\networking
mkdir bicep-modules\compute
```

Added `.gitkeep` files to track empty directories in Git:
```bash
New-Item bicep-modules\storage\.gitkeep -ItemType File
New-Item bicep-modules\networking\.gitkeep -ItemType File
New-Item bicep-modules\compute\.gitkeep -ItemType File
New-Item pipelines\.gitkeep -ItemType File
New-Item scripts\.gitkeep -ItemType File
New-Item docs\.gitkeep -ItemType File
```

### 2. Created .gitignore File
Implemented comprehensive .gitignore to protect sensitive data and exclude unnecessary files:
- Azure-specific patterns (parameters files, .azure cache)
- Terraform state files (future-proofing)
- Secrets and credentials (environment files, keys, certificates)
- OS-generated files (Thumbs.db, .DS_Store)
- IDE configuration files
- Build outputs and logs

### 3. Created Documentation Files
- `docs/day-01-setup.md` - Documented initial environment setup
- `docs/day-02-structure.md` - This file
- `docs/git-commands.md` - Reference guide for Git commands

### 4. Practiced Git Workflow
Made multiple commits throughout the day:
```bash
git add .
git commit -m "Add project folder structure"
git push

git add .gitignore
git commit -m "Add .gitignore for Azure project"
git push

git add docs/
git commit -m "Add Day 1 and Day 2 documentation and Git reference"
git push
```

## Key Learnings

### Git Behavior with Empty Folders
- Git does not track empty directories
- Solution: Add `.gitkeep` placeholder files to make folders visible to Git
- `.gitkeep` is a convention, not a Git feature - any file works, but `.gitkeep` signals intent

### .gitignore Best Practices
- Always create .gitignore before committing sensitive files
- Defense in depth: gitignore prevents accidental commits even when using proper secret management
- Include patterns for tools you might use in the future (like Terraform)
- Once a file is committed to Git history, it's there forever - gitignore won't remove it

### Enterprise Secret Management
- **Best practice**: Store secrets in Azure Key Vault, reference them in parameter files
- **Pipeline pattern**: Use service connections and managed identities to access Key Vault
- **Local development**: Use .env files (gitignored) for testing, never hardcode
- .gitignore acts as a safety net against accidentally committing secrets

### Git Workflow
- `git status` shows what changed (unstaged vs staged)
- `git add .` stages all changes in current directory
- `git add <file>` stages specific file
- `git commit -m "message"` commits staged changes with description
- `git push` sends commits to GitHub
- Commit messages should be clear and descriptive

### Professional Documentation
- Document while working, not after
- Include what you learned, not just what you did
- Note challenges and how you solved them
- Use proper markdown formatting for readability

## Challenges Encountered
- **Empty folders not appearing in Git** - Learned that Git doesn't track empty directories. Resolved by adding `.gitkeep` placeholder files.
- **Understanding .gitignore patterns** - Researched the purpose of each pattern and learned about enterprise secret management practices with Key Vault.

## Key Insights
- Proper project structure from the start makes scaling easier
- .gitignore is not just about what you're doing today, but protecting against future mistakes
- Documentation is a professional skill - it shows your thought process and learning ability to employers
- Small, frequent commits with clear messages create a readable project history

## Tools & Concepts Practiced
- PowerShell (mkdir, New-Item commands)
- Git workflow (add, commit, push)
- Markdown formatting
- Project organization
- Security best practices

## Next Steps (Day 3)
- Practice Git branching workflow
- Create feature branch for new work
- Merge branch back to main
- Update progress in README
- Build muscle memory with Git commands

