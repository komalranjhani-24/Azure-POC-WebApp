# Azure-POC-WebApp

Requirements:
• Create a Git repository with a clean folder and file structure. - DONE
• Use Azure Verified Modules (AVM) wherever applicable. - DONE
• Create reusable Bicep modules and parameter files following best practices.
• Set up Azure DevOps Managed DevOps Pools using Microsoft-managed agents with virtual network connectivity. - .5 DONE
• Configure secure authentication and appropriate Azure permissions. - DONE
• Create reusable Azure DevOps YAML pipelines and templates. .5 DONE
• Implement Bicep linting, validation, what-if analysis and deployment stages. - .5 DONE
• Deploy an Azure Web App, Azure SQL Database and Azure Key Vault using Bicep. - .5 DONE
• Test the pipeline and verify successful deployments.   - DONE
• Document the setup and process for deploying additional Azure resources. - DONE
 
EXPECTED DELIVERABLES
 
• Git repository with complete source code and folder structure.  - DONE
• Working Azure DevOps pipeline using the managed agent pool.   - DONE
• Reusable Bicep modules using AVM wherever applicable.   - DONE
• Basic architecture diagram.    - DONE
• README with setup and deployment instructions.   - DONE

---------------------------------------------------------------------------------------
Architecture Explaination:
Platform Landing Zone - VNET, AD, Firewall, Private DNS Zones)

Application Landing Zone - KV, App, SQL

Vnet peering to bridge communication between both vnet and subscriptions to reduce blast radius and re-usability and reduce overheads.

Current : APP, KV and SQL in VNET ; 
APP - subnet 1, 
KV, SQL - subnet 2

App <->  Private DNS  <-> PE <-> KV / SQL (Public access disabled)

-------------------------------------------------------------------------------------
3-tier application deployment via Azure Verified Modules (Bicep)

1. create a architectural basic diagram
2. https://azure.microsoft.com/free/ and signed up for an Azure Free Account & ADO setup
3. Vscode setup with bicep extension
4. Azure cli setup
5. Manually created RG to verify
6. Deployed  a basic RG setup via bicep to verify the configurations
7. Complete the Bicep for all resources as per architecture 
8. Convert to AVM Bicep (pending)
9. https://bjompen.com/#/posts/azdo.mdp?id=azure-devops-managed-devops-pools & https://learn.microsoft.com/en-us/azure/devops/managed-devops-pools/prerequisites?view=azure-devops&tabs=azure-portal#configure-your-azure-subscription     : Setting up MDP doc
10. MDP setup and configuration set - tested hello world pipeline
11. To test bicep deployment of RG (basic) via Pipeline (pending) - ENTRAID / APP RESGISTRATION WAS RESTRICTED FOR SERVICE CONNECTION CREATION - workaround created MI suing az cli and linked with SC
12. AVM bicep script creation - reference - https://azure.github.io/Azure-Verified-Modules/indexes/bicep/bicep-resource-modules/
