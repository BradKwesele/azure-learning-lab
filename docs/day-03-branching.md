# Day 3 Summary - February 4, 2026

## Overview
Implemented Git branching workflow and practiced feature-based development patterns used in professional software teams.

## Tasks Completed

### 1. Git Branching Fundamentals
Created and managed feature branches for isolated development:
```bash
git checkout -b feature/add-azure-notes
git checkout -b feature/update-readme-progress
git checkout -b feature/add-day3-docs
```

### 2. Feature Branch Workflow
Implemented professional branching pattern:
1. Created feature branch from main
2. Made changes and commits on feature branch
3. Switched back to main
4. Merged feature branch into main
5. Deleted feature branch after merge

### 3. Documentation Expansion
Created technical documentation:
- `docs/azure-basics.md` - Azure fundamentals (resource groups, subscriptions, regions)
- `docs/bicep-intro.md` - Bicep overview and comparison with alternatives
- Updated README.md with progress tracking

### 4. Branch Management
Practiced branch operations:
```bash
git branch                    # List branches
git checkout main             # Switch to main
git merge feature/branch-name # Merge feature into main
git branch -d feature/name    # Delete merged branch
```

## Technical Learnings

### Git Branching Model
**Why branches matter in professional environments:**
- **Isolation**: Work on features without affecting production code
- **Collaboration**: Multiple developers work simultaneously without conflicts
- **Review**: Changes can be reviewed before merging
- **Rollback**: Easy to discard failed experiments

**Branch naming conventions:**
- `feature/` - New functionality
- `bugfix/` - Bug fixes
- `hotfix/` - Urgent production fixes
- `docs/` - Documentation updates

### Merge Strategies
**Fast-forward merge** (what we practiced):
- Simplest merge type
- Moves main pointer forward to feature branch
- Creates linear history
- Works when main hasn't changed since branch creation

**Future learning**: Three-way merges, merge conflicts, pull requests

### Azure Fundamentals
**Resource hierarchy understanding:**
```
Management Group (optional)
└── Subscription
    └── Resource Group
        └── Resources
```

**Naming conventions importance:**
- Enables automation and scripting
- Improves cost tracking and organization
- Standard pattern: `<type>-<app>-<env>-<region>-<instance>`

### Infrastructure as Code - Bicep
**Key differentiators:**
- Azure-native with no state file management
- Simpler syntax than ARM JSON templates
- Strong typing and IntelliSense support
- Module system for reusability

**Bicep vs Terraform decision factors:**
- Bicep: Azure-only, native integration, no state management
- Terraform: Multi-cloud, mature ecosystem, requires state management

## Problem Solving

**Challenge**: Understanding when files "disappear" when switching branches

**Root Cause**: Git switches the working directory to match the target branch's state. Files only on feature branches aren't visible when on main.

**Resolution**: This is expected behavior - branches maintain separate states until merged. Verified by switching between branches and observing file presence/absence.

**Challenge**: Determining appropriate level of detail for documentation

**Approach**: 
- Technical documentation should be reference-quality
- Include context (why, not just what)
- Code examples for practical application
- Comparison tables for decision-making

## Professional Development
- Practiced workflow used in enterprise development teams
- Built habit of feature-based development (no direct commits to main)
- Developed technical writing skills with structured documentation
- Demonstrated understanding of IaC tool selection criteria

## Git Commands Reference

### Branch Operations
```bash
git branch                      # List all branches
git branch <name>               # Create new branch
git checkout <name>             # Switch to branch
git checkout -b <name>          # Create and switch in one command
git merge <branch>              # Merge branch into current branch
git branch -d <name>            # Delete merged branch
git branch -D <name>            # Force delete unmerged branch
```

### Workflow Pattern
```bash
# Start new feature
git checkout -b feature/new-feature

# Work and commit
git add .
git commit -m "Add feature implementation"

# Finish feature
git checkout main
git merge feature/new-feature
git push
git branch -d feature/new-feature
```

## Key Insights
- Branching enables fearless experimentation - failed attempts can be discarded
- Professional teams never commit directly to main/master
- Descriptive branch names improve project clarity
- Clean branch hygiene (deleting merged branches) maintains repository clarity
- Documentation is code - treat it with the same rigor

## Next Steps
- Set up Azure subscription
- Create first Azure resource groups via CLI
- Practice resource creation and deletion
- Begin Azure resource management workflow