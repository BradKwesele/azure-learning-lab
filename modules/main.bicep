// modules/main.bicep
// Master orchestrator — deploys a complete secure environment
// Wires networking, compute, storage, security, and RBAC together

// ============================================================
// PARAMETERS
// ============================================================

@description('Base name prefix for all resources')
param baseName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Environment name — used for tagging and naming')
@allowed([
  'dev'
  'staging'
  'prod'
])
param environment string = 'dev'

@description('Admin username for the Linux VM')
param vmAdminUsername string = 'azureuser'

@description('SSH public key for VM authentication')
@secure()
param vmSshPublicKey string

@description('VNet address space')
param vnetAddressPrefix string = '10.0.0.0/16'

@description('Subnet configurations')
param subnets array = [
  {
    name: 'snet-app'
    addressPrefix: '10.0.1.0/24'
  }
  {
    name: 'snet-data'
    addressPrefix: '10.0.2.0/24'
  }
]

// Common tags applied to every resource
var tags = {
  environment: environment
  managedBy: 'bicep'
  project: baseName
}

// ============================================================
// MODULES
// ============================================================

// 1. NETWORKING — VNet with NSG-protected subnets
module networking 'networking/main.bicep' = {
  name: 'deploy-networking'
  params: {
    vnetName: '${baseName}-vnet-${environment}'
    location: location
    addressPrefix: vnetAddressPrefix
    subnets: subnets
    tags: tags
  }
}

// 2. STORAGE — Hardened storage account
module storage 'storage/storage-account.bicep' = {
  name: 'deploy-storage'
  params: {
    // Storage account names: no hyphens, lowercase, max 24 chars
    storageAccountName: '${replace(baseName, '-', '')}st${environment}'
    location: location
    tags: tags
  }
}

// 3. SECURITY — Key Vault with RBAC authorization
module keyVault 'security/keyvault.bicep' = {
  name: 'deploy-keyvault'
  params: {
    keyVaultName: '${baseName}-kv-${environment}'
    location: location
    tags: tags
  }
}

// 4. COMPUTE — Linux VM inside the app subnet
module linuxVm 'compute/vm-linux.bicep' = {
  name: 'deploy-linux-vm'
  params: {
    vmName: '${baseName}-vm-${environment}'
    location: location
    subnetId: networking.outputs.subnetIds[0].id
    vmSize: 'Standard_B1s'
    adminUsername: vmAdminUsername
    sshPublicKey: vmSshPublicKey
    tags: tags
  }
}

// 5. RBAC — Grant the VM's managed identity access to Key Vault secrets
module vmKeyVaultAccess 'security/rbac-assignment.bicep' = {
  name: 'deploy-vm-keyvault-rbac'
  params: {
    principalId: linuxVm.outputs.principalId
    principalType: 'ServicePrincipal'
    // Key Vault Secrets User role
    roleDefinitionId: '4633458b-17de-408a-b874-0445c86b69e6'
    scope: keyVault.outputs.keyVaultId
  }
}

// 6. RBAC — Grant the VM's managed identity access to Storage blobs
module vmStorageAccess 'security/rbac-assignment.bicep' = {
  name: 'deploy-vm-storage-rbac'
  params: {
    principalId: linuxVm.outputs.principalId
    principalType: 'ServicePrincipal'
    // Storage Blob Data Contributor role
    roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
    scope: storage.outputs.storageAccountId
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('VNet resource ID')
output vnetId string = networking.outputs.vnetId

@description('Key Vault URI for app configuration references')
output keyVaultUri string = keyVault.outputs.keyVaultUri

@description('Storage account blob endpoint')
output storageBlobEndpoint string = storage.outputs.blobEndpoint

@description('VM name')
output vmName string = linuxVm.outputs.vmName

@description('VM private IP address')
output vmPrivateIp string = linuxVm.outputs.privateIpAddress
