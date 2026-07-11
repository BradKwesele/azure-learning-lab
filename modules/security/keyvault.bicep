// modules/security/keyvault.bicep
// Reusable Key Vault module with Microsoft security best practices

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the Key Vault (must be globally unique, 3-24 chars)')
@minLength(3)
@maxLength(24)
param keyVaultName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Azure AD tenant ID — required for Key Vault')
param tenantId string = subscription().tenantId

@description('Enable soft delete — prevents permanent deletion of secrets')
param enableSoftDelete bool = true

@description('Number of days to retain soft-deleted secrets (7-90)')
@minValue(7)
@maxValue(90)
param softDeleteRetentionInDays int = 90

@description('Enable purge protection — once on, cannot be turned off')
param enablePurgeProtection bool = true

@description('Tags for resource governance and cost tracking')
param tags object = {
  environment: 'dev'
  managedBy: 'bicep'
}

// ============================================================
// RESOURCES
// ============================================================

resource keyVault 'Microsoft.KeyVault/vaults@2024-04-01-preview' = {
  name: keyVaultName
  location: location
  tags: tags
  properties: {
    tenantId: tenantId

    // SECURITY: Use Azure RBAC for access control instead of legacy access policies
    // RBAC is Microsoft's recommended approach as of 2024+
    // With RBAC, you assign roles like "Key Vault Secrets User" to specific identities
    // instead of granting broad vault-level permissions through access policies
    enableRbacAuthorization: true

    // SECURITY: Soft delete keeps deleted secrets recoverable for the retention period
    // This protects against accidental deletion — someone deletes a production secret,
    // you can recover it instead of having a full outage
    enableSoftDelete: enableSoftDelete
    softDeleteRetentionInDays: softDeleteRetentionInDays

    // SECURITY: Purge protection prevents anyone from permanently deleting secrets
    // during the retention period — even admins can't bypass it
    // Once enabled, this CANNOT be turned off — it's a one-way switch
    enablePurgeProtection: enablePurgeProtection

    // SECURITY: Default deny all network access
    // Only explicitly allowed networks or private endpoints can reach this vault
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }

    // SKU standard is sufficient for most workloads
    // Premium adds HSM-backed keys (hardware security modules) for compliance requirements
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('Resource ID of the Key Vault')
output keyVaultId string = keyVault.id

@description('Name of the Key Vault')
output keyVaultName string = keyVault.name

@description('URI of the Key Vault — used in Key Vault references')
output keyVaultUri string = keyVault.properties.vaultUri
