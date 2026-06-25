# Networking Modules

Reusable Bicep modules for Azure networking with security-first defaults.

## Modules

### vnet.bicep
Deploys a virtual network with configurable subnets. Each subnet gets its own
NSG with a default-deny inbound rule from internet.

### nsg-rules.bicep
Adds security rules to an existing NSG. Designed to layer allow rules on top
of the default-deny already set by the VNet module.

### main.bicep
Orchestrator that deploys a complete networking stack — VNet, subnets, NSGs,
and security rules in one deployment.

## Security Defaults

- Every subnet gets its own NSG automatically
- Default deny all inbound from internet (priority 4096)
- RDP (3389) explicitly denied from internet
- Allow rules added per-subnet based on workload needs

## Usage

Deploy the full networking stack:

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file modules/networking/main.bicep \
  --parameters vnetName='my-vnet'