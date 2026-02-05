# Azure Fundamentals

## What is a Resource Group?
A resource group is a logical container for Azure resources. All resources must belong to a resource group. Key characteristics:
- Resources in a group can be in different regions
- Deleting a resource group deletes all resources in it
- Used for organizing, managing permissions, and tracking costs
- Cannot be nested (no resource groups inside resource groups)

## What is a Subscription?
A subscription is a billing and access boundary in Azure. Key points:
- All Azure resources require a subscription
- Subscriptions have spending limits and quotas
- Can have multiple subscriptions for different departments/projects
- Each subscription has its own:
  - Billing account
  - Access control (RBAC)
  - Cost management

## Azure Regions
Azure has data centers worldwide organized into regions. Each region:
- Contains one or more data centers
- Is paired with another region for disaster recovery
- Has different service availability
- May have different pricing

### Common Regions:
- **East US** (Virginia) - Default for many services
- **West US** (California)
- **West Europe** (Netherlands)
- **UK South** (London)
- **Southeast Asia** (Singapore)

To list all available regions:
```bash
az account list-locations --output table
```

## Azure Resource Hierarchy
```
Management Group (optional)
└── Subscription
    └── Resource Group
        └── Resources (VMs, Storage, etc.)
```

## Resource Naming Conventions
Following consistent naming helps organization and automation:

**Pattern**: `<resource-type>-<workload/app>-<environment>-<region>-<instance>`

**Examples:**
- `rg-webapp-prod-eastus-001` (Resource Group)
- `st-webapp-prod-eastus-001` (Storage Account)
- `vm-webapp-prod-eastus-001` (Virtual Machine)
- `kv-webapp-prod-eastus-001` (Key Vault)

**Common abbreviations:**
- rg = Resource Group
- st = Storage Account
- vm = Virtual Machine
- vnet = Virtual Network
- kv = Key Vault
- sql = SQL Database