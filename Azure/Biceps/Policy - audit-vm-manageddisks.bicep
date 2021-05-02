param policyAssignmentName string = 'audit-vm-manageddisks'
param policyDefinitionID string = '/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d'

resource assignment 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
    name: policyAssignmentName
    properties: {
        scope: subscriptionResourceId('Microsoft.Resources/resourceGroups', resourceGroup().name)
        policyDefinitionId: policyDefinitionID
    }
}

output assignmentId string = assignment.id