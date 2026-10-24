targetScope = 'subscription'

@description('Resource Group Name')
param rgName string = 'rg-avm-poc'

@description('Azure Region')
param location string = 'centralindia'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: location
}