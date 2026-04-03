# Introduction to Bicep

## What is Bicep?
Bicep is a Domain Specific Language (DSL) for deploying Azure resources declaratively. It's a more readable alternative to ARM (Azure Resource Manager) templates.

## Why Bicep vs ARM Templates?
- **Simpler syntax** - Less verbose than JSON
- **Better tooling** - IntelliSense in VS Code
- **Easier to learn** - More intuitive structure
- **Modules** - Reusable components
- **No state management** - Unlike Terraform, no .tfstate files

## Bicep vs Terraform
| Feature | Bicep | Terraform |
|---------|-------|-----------|
| Cloud Support | Azure only | Multi-cloud |
| State Management | Azure handles it | Manual .tfstate files |
| Language | Declarative DSL | HCL |
| Maturity | Newer (2021) | Established (2014) |

**When to use Bicep:**
- Azure-only infrastructure
- Want native Azure integration
- Prefer not managing state files

**When to use Terraform:**
- Multi-cloud infrastructure
- Need to manage AWS, GCP, Azure together
- Large existing Terraform codebase

## Basic Bicep Structure
```bicep
// Parameters - inputs to the template
param storageAccountName string
param location string = 'eastus'

// Variables - calculated values
var storageAccountSku = 'Standard_LRS'

// Resource definition
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
}

// Outputs - values to return after deployment
output storageAccountId string = storageAccount.id
```

## Key Concepts

### Parameters
Input values passed when deploying:
```bicep
param environmentName string
param location string = resourceGroup().location  // default value
```

### Variables
Calculated or reusable values:
```bicep
var uniqueName = '${prefix}-${uniqueString(resourceGroup().id)}'
```

### Resources
The actual Azure resources to create:
```bicep
resource resourceName 'resourceType@apiVersion' = {
  // properties
}
```

### Outputs
Values returned after deployment:
```bicep
output endpoint string = storageAccount.properties.primaryEndpoints.blob
```

## Next Steps for Learning Bicep
1. Study the Bicep template syntax
2. Create simple templates (storage account, VNet)
3. Learn about modules (reusable components)
4. Practice parameterization
5. Deploy via Azure CLI: `az deployment group create`