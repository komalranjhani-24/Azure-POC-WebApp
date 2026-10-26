
targetScope = 'resourceGroup'

@description('Environment Prefix')
param envPrefix string = 'dev'

@description('Location')
param location string = resourceGroup().location

module vnet   'br/public:avm/res/network/virtual-network:0.10.2' =  {
  params: {
    name: '${envPrefix}-vnet'
    location: location

    addressPrefixes: [
      '10.0.0.0/16'
    ]

    subnets: [
      {
        name: 'app-subnet'
        addressPrefix: '10.0.1.0/27'
      }
      {
        name: 'pe-subnet'
        addressPrefix: '10.0.2.0/27'
      }
    ]
  }
}

module serverfarms  'br/public:avm/res/web/serverfarm:0.7.0' = {
  params: {
     name: '${envPrefix}-plan'
     location: location
     skuName: 'F1'
     skuCapacity: 1
     kind: 'linux'
     reserved: true  }
}

module site 'br/public:avm/res/web/site:0.24.0' =  {
  params: {
    name: 'dev-app'
    kind: 'app'
    serverFarmResourceId: serverfarms.outputs.resourceId
    virtualNetworkSubnetResourceId: vnet.outputs.subnetResourceIds[0]
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}




