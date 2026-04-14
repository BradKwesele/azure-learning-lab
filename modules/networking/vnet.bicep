// modules/networking/vnet.bicep
// Reusable Virtual Network module with security defaults

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the virtual network')
param vnetName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Address space for the virtual network')
param addressPrefix string = '10.0.0.0/16'

@description('Array of subnet configurations')
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

@description('Tags for resource governance and cost tracking')
param tags object = {
  environment: 'dev'
  managedBy: 'bicep'
}

// ============================================================
// RESOURCES
// ============================================================

// NSG for each subnet — default-deny inbound from internet
resource nsgs 'Microsoft.Network/networkSecurityGroups@2024-01-01' = [for subnet in subnets: {
  name: 'nsg-${subnet.name}'
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'DenyAllInboundFromInternet'
        properties: {
          priority: 4096
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourceAddressPrefix: 'Internet'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
          description: 'Default deny all inbound traffic from internet'
        }
      }
    ]
  }
}]

// Virtual network with NSG-protected subnets
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [for (subnet, i) in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        networkSecurityGroup: {
          id: nsgs[i].id
        }
      }
    }]
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('Resource ID of the virtual network')
output vnetId string = virtualNetwork.id

@description('Name of the virtual network')
output vnetName string = virtualNetwork.name

@description('Array of subnet resource IDs')
output subnetIds array = [for (subnet, i) in subnets: {
  name: subnets[i].name
  id: virtualNetwork.properties.subnets[i].id
}]

@description('Array of NSG resource IDs')
output nsgIds array = [for (subnet, i) in subnets: {
  name: 'nsg-${subnets[i].name}'
  id: nsgs[i].id
}]
