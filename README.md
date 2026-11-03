# The Tangle

The Azure infrastructure for Tumbleweed Logistics' dispatch platform, as inherited.

The engineer who built it left. He didn't leave notes. He left this.

This repo is the running example for the book **SchematIaC: Visual Infrastructure as Code**. Every chapter from Chapter 4 on opens it and untangles one knot. Nothing here needs to be deployed. SchematIaC reads the files as they are, no Terraform or Bicep CLI required.

## What's in it

```
.                     Terraform root: the dispatch platform
modules/              network, app, data, messaging, monitoring, keyvault
dev.tfvars            dev environment
prod.tfvars           prod environment
bicep/carrier-edi/    the carrier EDI function. Still Bicep. "Port later."
```

Two environments, three resource groups, six modules, a web portal, an API, a SQL database, a storage account full of shipping paperwork, a Service Bus, a Key Vault, monitoring, a Function App in a different language, and one NAT gateway that nobody can explain.

## Follow along

1. Install [SchematIaC](https://marketplace.visualstudio.com/items?itemName=schematiac.schematiac) in VS Code.
2. Clone this repo and open the folder.
3. Start at Chapter 4.

Each chapter checkpoint is a git tag (`ch05`, `ch06`, ...). To see the repo as it stands at the start of a chapter, check out the tag for the chapter before it. `main` is the inherited state: the starting line.

## Is this real?

Tumbleweed Logistics is made up. Rattlesnake Freight is made up. The Terraform and Bicep are real, written against the real `azurerm` provider and the real Azure resource types, with real mistakes of the kind real inherited infrastructure has. If you spot one the book doesn't cover, open an issue. You've probably found a chapter.
