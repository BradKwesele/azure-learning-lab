// modules/storage/storage-account.bicep
// Reusable Storage Account module with Microsoft security best practices

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the storage account (must be globally unique, 3-24 chars, lowercase and numbers only)')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Storage account SKU — defines redundancy level')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
])
param skuName string = 'Standard_LRS'

@description('Storage account kind')
@allowed([
  'StorageV2'
  'BlobStorage'
])
param kind string = 'StorageV2'

@description('Tags for resource governance and cost tracking')
param tags object = {
  environment: 'dev'
  managedBy: 'bicep'
}

// ============================================================
// RESOURCES
// ============================================================

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: skuName
  }
  kind: kind
  properties: {

    // SECURITY: Require HTTPS — blocks unencrypted HTTP requests
    supportsHttpsTrafficOnly: true

    // SECURITY: Enforce TLS 1.2 minimum — older versions have known vulnerabilities
    minimumTlsVersion: 'TLS1_2'

    // SECURITY: Block anonymous public access to blobs
    // This is the #1 misconfiguration that leads to data leaks
    allowBlobPublicAccess: false

    // SECURITY: Disable shared key access, force Entra ID (Azure AD) authentication
    // This means no one can use storage account keys — only managed identity or RBAC
    allowSharedKeyAccess: false

    // SECURITY: Default deny all network access
    // Only explicitly allowed networks or private endpoints can reach this account
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }

    // Encryption with Microsoft-managed keys (default, free)
    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('Resource ID of the storage account')
output storageAccountId string = storageAccount.id

@description('Name of the storage account')
output storageAccountName string = storageAccount.name

@description('Primary blob endpoint')
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob
