// modules/security/rbac-assignment.bicep
// Reusable RBAC role assignment module — connects identity to permissions

// ============================================================
// PARAMETERS
// ============================================================

@description('Principal ID of the identity receiving the role (e.g., VM managed identity)')
param principalId string

@description('Type of principal receiving the role')
@allowed([
  'ServicePrincipal'
  'User'
  'Group'
])
param principalType string = 'ServicePrincipal'

@description('Role definition ID to assign — use built-in role GUIDs')
param roleDefinitionId string

@description('Scope at which to assign the role (resource ID of target resource)')
param scope string = resourceGroup().id

// ============================================================
// RESOURCES
// ============================================================

// SECURITY: Each assignment grants ONE specific role to ONE specific identity
// This enforces least privilege — no broad "Contributor" or "Owner" roles
// Common roles you'll use:
//   Key Vault Secrets User:    4633458b-17de-408a-b874-0445c86b69e6
//   Storage Blob Data Reader:  2a2b9908-6ea1-4ae2-8e65-a410df84e7d1
//   Storage Blob Data Contributor: ba92f5b4-2d11-453d-a403-e96b0029c9fe
//   Reader:                    acdd72a7-3385-48ef-bd42-f606fba81ae7

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(scope, principalId, roleDefinitionId)
  properties: {
    principalId: principalId
    principalType: principalType
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)
  }
}

// ============================================================
// OUTPUTS
// ============================================================

@description('Resource ID of the role assignment')
output roleAssignmentId string = roleAssignment.id
