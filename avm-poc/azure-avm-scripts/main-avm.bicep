
targetScope = 'resourceGroup'

@description('Environment Prefix')
param envPrefix string = 'dev'

@description('Location')
param location string = resourceGroup().location

@secure()
param sqlAdminPassword string


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
        delegation: 'Microsoft.Web/serverFarms'
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
     skuName: 'B1'
     skuCapacity: 1
     kind: 'linux'
     reserved: true  }
}

module site 'br/public:avm/res/web/site:0.24.0' =  {
  params: {
    name: 'dev-app-poc'
    kind: 'app'
    serverFarmResourceId: serverfarms.outputs.resourceId
    virtualNetworkSubnetResourceId: vnet.outputs.subnetResourceIds[0]
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
    }
  }
}

module sql 'br/public:avm/res/sql/server:0.22.1' =  {
  params: {
    name: '${envPrefix}-sql-server-poc' 
    location: location
    administratorLogin: 'sqladmin'
    administratorLoginPassword: sqlAdminPassword
  }
}

module db 'br/public:avm/res/sql/server/database:0.3.1' = {
  params: {
    name: '${sql.name}-db'
    availabilityZone: 1
    serverName: sql.name
    location: location
    sku: {
      name: 'Basic'
    }
  }
}

module kv 'br/public:avm/res/key-vault/vault:0.14.2' = {
  params: {
    name: 'kv-${resourceGroup().name}'
    location: location
    sku: 'standard'
    enableRbacAuthorization: true  
  }
}
