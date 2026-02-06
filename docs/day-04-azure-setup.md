# Day 4 Summary - February 5, 2026

## Overview
Configured Azure subscription and practiced resource lifecycle management through Azure Portal and CLI, including resource group and storage account creation and deletion. Encountered and documented Azure CLI authentication issues.

## Tasks Completed

### 1. Azure Subscription Setup
Configured Azure free account with $200 credit and 12 months of free services:
```bash
az login
az account list --output table
az account show --output table
```

**Subscription verified:**
- Name: Azure subscription 1
- State: Enabled
- Successfully authenticated via browser

### 2. Azure Region Exploration
Explored available Azure regions and identified commonly used locations:
```bash
az account list-locations --output table
az account list-locations --query "[].{DisplayName:displayName, Name:name}" --output table
```

**Selected region for lab:** `eastus` (Virginia)
- Cost-effective
- Full service availability
- Low latency for US East Coast

### 3. Resource Group Management
Created resource group via Azure CLI:
```bash
# Create resource group
az group create --name rg-learning-lab-dev --location eastus

# Verify creation
az group list --output table
az group show --name rg-learning-lab-dev --output json
```

**Resource group details:**
- Name: `rg-learning-lab-dev`
- Location: East US
- Provisioning State: Succeeded

### 4. Storage Account Creation
Created Azure Storage account via Azure Portal due to CLI authentication issues:

**Configuration:**
- Name: `stlearninglab001`
- Resource Group: `rg-learning-lab-dev`
- Region: (US) East US
- Performance: Standard
- Redundancy: Locally-redundant storage (LRS)
- Preferred storage type: Azure Blob Storage or Azure Data Lake Storage Gen 2

### 5. Azure Portal Exploration
Explored created resources in Azure Portal:
- Navigated to Resource Groups
- Inspected storage account properties
- Explored storage account configuration options
- Validated resource metadata and settings

### 6. Resource Cleanup
Deleted resources via Azure Portal to avoid charges:
- Deleted storage account: `stlearninglab001`
- Deleted resource group: `rg-learning-lab-dev`
- Verified all resources removed

## Technical Learnings

### Resource Groups
**Purpose and characteristics:**
- Logical container for related Azure resources
- All resources must belong to a resource group
- Resources can be in different regions than their resource group
- Deleting a resource group deletes all contained resources
- Used for access control (RBAC), cost tracking, and organization

**Naming convention implemented:**
```
rg-<workload>-<environment>-<region>-<instance>
Example: rg-learning-lab-dev-eastus-001
```

### Storage Accounts
**Naming constraints:**
- 3-24 characters
- Lowercase letters and numbers only
- Globally unique across all Azure tenants
- No hyphens or special characters

**Performance tiers:**
- **Standard** - HDD-based, cost-effective for most scenarios
- **Premium** - SSD-based, for high-performance workloads

**Redundancy options:**
- **LRS (Locally Redundant Storage)** - 3 copies in one datacenter, cheapest
- **ZRS (Zone-Redundant Storage)** - Copies across availability zones
- **GRS (Geo-Redundant Storage)** - 6 copies across two regions
- **GZRS** - Combination of ZRS and GRS, most expensive

**Storage account types:**
- **StorageV2** - General purpose v2 (recommended, supports all features)
- **BlobStorage** - Blob-only storage (legacy)
- **BlockBlobStorage** - Premium block blobs only

**Preferred storage types:**
- Azure Blob Storage or Azure Data Lake Storage Gen 2 (most common)
- Azure Files (SMB file shares)
- Other (tables and queues)

### Azure CLI Patterns
**Common output formats:**
- `--output table` - Human-readable table format
- `--output json` - Full JSON response (default)
- `--output jsonc` - Colored JSON
- `--output tsv` - Tab-separated values

**Query filtering:**
```bash
az account list-locations --query "[].{DisplayName:displayName, Name:name}" --output table
```
Uses JMESPath query syntax to filter and format output.

**Useful verification commands:**
```bash
az account show                           # Show active subscription
az group list --output table              # List all resource groups
az group show --name <name>               # Show specific resource group details
az storage account list --output table    # List all storage accounts
```

### Resource Lifecycle Management
**Best practices observed:**
1. **Create resources in development environment first**
2. **Use consistent naming conventions** for automation and organization
3. **Delete unused resources immediately** to avoid unnecessary costs
4. **Verify creation before proceeding** with dependent resources
5. **Understand resource dependencies** before deletion

## Problem Solving

### Challenge 1: Azure CLI Subscription Authentication Error

**Symptom**: 
```
(SubscriptionNotFound) Subscription 1b62e336-405e-457d-aef6-40bc9dbe5700 was not found.
```

**Investigation steps:**
1. Verified login status: `az account show` - returned valid subscription data
2. Verified subscription list: `az account list --output table` - subscription visible
3. Verified resource group exists: `az group show --name rg-learning-lab-dev` - successful
4. Attempted storage account creation multiple times - persistent failure
5. Tried explicit subscription parameter - still failed

**Root cause hypothesis:**
- Azure CLI credential caching issue
- Possible bug in Azure CLI version being used
- Token refresh problem between commands

**Workaround implemented:**
- Created storage account via Azure Portal instead of CLI
- Portal authentication worked without issues
- Completed learning objectives using Portal GUI

**Future remediation:**
- Consider running `az account clear` and re-authenticating
- Update Azure CLI to latest version: `az upgrade`
- Alternative: Use Azure Cloud Shell (built into Portal)
- File issue with Azure CLI team if problem persists

**Key learning:** Always have multiple tools available. Portal GUI and CLI are complementary - when one fails, the other provides a backup path.

### Challenge 2: Understanding Storage Account Global Uniqueness

**Context**: Storage account names must be globally unique across all Azure tenants.

**Approach:**
- Used descriptive but unique naming pattern
- Added numeric suffix for uniqueness
- Pattern: `stlearninglab[number]`

**Learning:** In production, use naming conventions that include:
- Organization identifier
- Environment indicator  
- Sequential numbers or GUIDs for uniqueness

## Cost Management Insights

**Free tier understanding:**
- $200 credit for first 30 days
- Some services always free (limited quantities)
- Resources accrue charges while they exist (even if not actively used)
- Importance of immediate cleanup after learning/testing

**Cost control practices implemented:**
- Deleted resources immediately after exploration
- Used cheapest options for learning:
  - Standard performance tier
  - LRS redundancy
- Verified all resources deleted via Portal
- Set mental reminder to check for orphaned resources regularly

**Future practices:**
- Set up spending alerts
- Use Azure Cost Management + Billing
- Tag resources for cost tracking
- Implement auto-shutdown for VMs (when used)

## Azure Portal vs CLI

**Portal advantages:**
- Visual resource inspection
- Guided creation wizards
- Easier for initial learning and exploration
- Built-in documentation and help
- No local tool installation required

**CLI advantages:**
- Automation and scripting
- Repeatable deployments
- Faster for experienced users
- Essential for CI/CD pipelines
- Infrastructure as Code workflows
- Batch operations

**Professional practice:** 
- Learn both tools
- Use Portal for exploration and one-off tasks
- Use CLI/IaC for production and automated workflows
- Portal creates CLI commands you can copy (see "Automation" section)

## Commands Reference

### Account Management
```bash
az login                                    # Authenticate to Azure
az account list --output table              # List subscriptions
az account show --output table              # Show active subscription
az account set --subscription "name"        # Set active subscription
az account clear                            # Clear cached credentials
```

### Resource Group Operations
```bash
az group create --name <name> --location <location>
az group list --output table
az group show --name <name>
az group delete --name <name> --yes --no-wait
```

### Storage Account Operations (CLI - when working)
```bash
az storage account create \
  --name <name> \
  --resource-group <rg> \
  --location <location> \
  --sku Standard_LRS \
  --kind StorageV2

az storage account list --resource-group <rg> --output table
az storage account show --name <name> --resource-group <rg>
az storage account delete --name <name> --resource-group <rg> --yes
```

### Troubleshooting Commands
```bash
az --version                    # Check CLI version
az upgrade                      # Update Azure CLI
az account clear                # Clear credential cache
az login --use-device-code      # Alternative login method
```

## Key Insights

### Technical
- Azure CLI provides programmatic control over Azure resources
- Portal and CLI are complementary tools, each with strengths
- Resource groups enable logical organization and bulk operations
- Consistent naming conventions are foundational for automation
- Every resource creation should have a corresponding deletion plan

### Professional
- Troubleshooting is part of the learning process
- Always have backup approaches (Portal when CLI fails)
- Document problems encountered and workarounds used
- Real-world environments have issues - adaptability matters
- Cost consciousness should be built into habits from day one

### Learning Process
- Hands-on experience reveals edge cases not covered in documentation
- Problem-solving skills are as valuable as technical knowledge
- Flexibility in tooling demonstrates professional maturity
- Documentation of failures is as important as successes

## Professional Development
- Demonstrated adaptability when encountering tool limitations
- Practiced cost-conscious cloud resource management
- Understood Azure resource hierarchy and relationships
- Built foundation for Infrastructure as Code implementation
- Developed troubleshooting methodology for authentication issues

## Next Steps
- Troubleshoot and resolve Azure CLI authentication issue
- Continue practicing resource creation/deletion workflows
- Prepare for Week 3: Begin Bicep template development
- Review Azure naming conventions for enterprise patterns
- Explore Azure Cost Management dashboard