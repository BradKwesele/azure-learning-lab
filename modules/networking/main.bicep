// modules/networking/main.bicep
// Orchestrator that deploys VNet and NSG rules together

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the virtual network')
param vnetName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('VNet address space')
param addressPrefix string = '10.0.0.0/16'

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

@description('Tags for resource governance')
param tags object = {
  environment: 'dev'
  managedBy: 'bicep'
}

// ============================================================
// MODULES
// ============================================================

// Deploy the VNet with NSG-protected subnets
module vnet 'vnet.bicep' = {
  name: 'deploy-vnet'
  params: {
    vnetName: vnetName
    location: location
    addressPrefix: addressPrefix
    subnets: subnets
    tags: tags
  }
}

// Add HTTPS allow rule to the app subnet NSG
module appNsgRules 'nsg-rules.bicep' = {
  name: 'deploy-app-nsg-rules'
  dependsOn: [vnet]
  params: {
    nsgName: 'nsg-snet-app'
    securityRules: [
      {
        name: 'AllowHTTPS'
        priority: 100
        direction: 'Inbound'
        access: 'Allow'
        protocol: 'Tcp'
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
        destinationAddressPrefix: '*'
        destinationPortRange: '443'
        description: 'Allow HTTPS inbound'
      }
      {
        name: 'DenyRDPFromInternet'
        priority: 200
        direction: 'Inbound'
        access: 'Deny'
        protocol: 'Tcp'
        sourceAddressPrefix: 'Internet'
        sourcePortRange: '*'
        destinationAddressPrefix: '*'
        destinationPortRange: '3389'
        description: 'Explicitly deny RDP from internet'
      }
    ]
  }
}

// ============================================================
// OUTPUTS
// ============================================================

output vnetId string = vnet.outputs.vnetId
output subnetIds array = vnet.outputs.subnetIds
