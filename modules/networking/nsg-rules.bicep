// modules/networking/nsg-rules.bicep
// Reusable NSG rules module — adds allow rules to an existing NSG
// Works on top of the default-deny already set in the VNet module

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the existing NSG to add rules to')
param nsgName string

@description('Array of security rules to apply')
param securityRules array

// ============================================================
// RESOURCES
// ============================================================

// Reference the existing NSG (created by the VNet module)
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-01-01' existing = {
  name: nsgName
}

// Add individual rules to the existing NSG
resource rules 'Microsoft.Network/networkSecurityGroups/securityRules@2024-01-01' = [for rule in securityRules: {
  parent: nsg
  name: rule.name
  properties: {
    priority: rule.priority
    direction: rule.direction
    access: rule.access
    protocol: rule.protocol
    sourceAddressPrefix: rule.sourceAddressPrefix
    sourcePortRange: rule.sourcePortRange
    destinationAddressPrefix: rule.destinationAddressPrefix
    destinationPortRange: rule.destinationPortRange
    description: rule.description
  }
}]
