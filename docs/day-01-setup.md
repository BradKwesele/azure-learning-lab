# Day 1 Summary - February 2, 2026

## What I Accomplished Today
Set up development environment for Azure infrastructure learning, including repository initialization, authentication configuration, and required tooling installation.

## Tasks Completed

### 1. Created GitHub Repository
- Repository name: `azure-learning-lab`
- Visibility: Public
- Description: "Hands-on projects for Azure IaC, DevOps, CI/CD pipelines, and cloud security"
- Initialized with README

### 2. Cloned Repository Locally
```bash
cd ~/Documents/Projects/GitHub
git clone https://github.com/BradKwesele/azure-learning-lab.git
cd azure-learning-lab
```

### 3. Updated README.md
- Replaced default README with structured learning roadmap
- Defined clear goals and project scope
- Established 14-week learning path

### 4. First Git Commit
```bash
git add README.md
git commit -m "Learning lab roadmap and goals"
git push origin main
```

### 5. Set Up Git Authentication
- Configured Git credential manager for GitHub authentication
```bash
git config --global credential.helper manager
```
- Authenticated through browser on first push

### 6. Installed Azure CLI (64-bit)
- Opened PowerShell as Administrator
- Ran installation command:
```powershell
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindowsx64 -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I', 'AzureCLI.msi', '/quiet'
Remove-Item .\AzureCLI.msi
```
- Verified installation: `az --version`
- Tested login: `az login` (will configure subscription on Day 4)

### 7. Installed VS Code Extensions
- Azure Resources
- Bicep
- GitLens
- Note: Skipped "Azure Account" (deprecated)

## Key Learnings

### Git Basics
- `git clone` creates a local copy of a remote repository
- `git add` stages files for commit
- `git commit` saves changes locally with a message
- `git push` sends local commits to GitHub
- Authentication only needed once, then cached

### Azure CLI
- Must close and reopen terminal after installation for commands to work
- `az login` authenticates with Azure account
- Azure subscription required for resource deployment (configuring Day 4)

### Best Practices
- Use descriptive commit messages
- Install 64-bit software on 64-bit systems
- Use public repositories for portfolio/learning projects
- Maintain professional README formatting

## Challenges Encountered
- **Git authentication failure** - Resolved by configuring credential manager with `git config --global credential.helper manager`
- **Azure CLI command not recognized** - Resolved by restarting terminal after installation

## Tools Installed
- ✅ Git (previously installed)
- ✅ Azure CLI (64-bit version)
- ✅ VS Code with Azure extensions
- ✅ GitHub authentication configured

## Next Steps (Day 2)
- Create project folder structure
- Add .gitignore file
- Create documentation workflow
- Practice Git workflow with multiple commits