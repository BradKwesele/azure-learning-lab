// modules/compute/vm-linux.bicep
// Reusable Linux VM module with security best practices

// ============================================================
// PARAMETERS
// ============================================================

@description('Name of the virtual machine')
param vmName string

@description('Azure region for deployment')
param location string = resourceGroup().location

@description('Resource ID of the subnet to deploy the VM into')
param subnetId string

@description('VM size — controls CPU, memory, and cost')
@allowed([
  'Standard_B1s'
  'Standard_B2s'
  'Standard_D2s_v3'
])
param vmSize string = 'Standard_B1s'

@description('Admin username for SSH access')
param adminUsername string

@description('SSH public key for authentication')
@secure()
param sshPublicKey string

@description('Ubuntu OS version')
@allowed([
  '22_04-lts-gen2'
  '24_04-lts'
])
param ubuntuVersion string = '22_04-lts-gen2'

@description('Tags for resource governance and cost tracking')
param tags object = {
  environment: 'dev'
  managedBy: 'bicep'
}

// ============================================================
// RESOURCES
// ============================================================

// NIC with no public IP — VM is only accessible within the VNet
resource nic 'Microsoft.Network/networkInterfaces@2024-01-01' = {
  name: 'nic-${vmName}'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          // SECURITY: No public IP assigned — no direct internet exposure
        }
      }
    ]
  }
}

// Linux VM with managed identity and security hardening
resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
  tags: tags

  // SECURITY: System-assigned managed identity so the VM can authenticate
  // to other Azure services (Key Vault, Storage) without storing credentials
  identity: {
    type: 'SystemAssigned'
  }

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername

      // SECURITY: SSH key auth only — password authentication is disabled
      // Passwords can be brute-forced, SSH keys cannot
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
            }
          ]
        }
      }
    }

    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: ubuntuVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          // SECURITY: Encrypted at rest by default with platform-managed keys
          storageAccountType: 'Standard_LRS'
        }
      }
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('Resource ID of the virtual machine')
output vmId string = vm.id

@description('Name of the virtual machine')
output vmName string = vm.name

@description('Principal ID of the VM managed identity — use this for RBAC assignments')
output principalId string = vm.identity.principalId

@description('Private IP address of the VM')
output privateIpAddress string = nic.properties.ipConfigurations[0].properties.privateIPAddress
