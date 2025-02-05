# Getting Started with Terraform and Azure

**Get Started:** https://developer.hashicorp.com/terraform/tutorials <br>
**Get Started with Azure:** https://developer.hashicorp.com/terraform/tutorials/azure-get-started <br>
**Manage State in HCP Terraform to work with Team Mates:** https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate <br>


### Azure related commands

```
az login
```

See all subscriptions
```
az account list
```

Change Subscriptions
```
az account set --subscription "SubscriptionName"
```

Show current subscription in Azure
```
az account show --output table
```

Create a json file of the whole Azure services and configurations of a subscription
```
az resource list --output json > azure-resources.json
```

---

### Create a Service Principal
https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
A Service Principal is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf. Update the `<SUBSCRIPTION_ID>` with the subscription ID you specified in the previous step. **Save the output in a password manager**
```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```

Set the output as environment variables:
```bash
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"
```

---


If terraform is installed, run `terraform init` to initialize project.


#### Apply
See current running state
```bash
terraform plan
```

Format config. **Always do that when you apply changes**
```bash
terraform fmt
```

Validate config **Always do that when you apply changes**
```bash
terraform validate
```

Run the services
```bash
terraform apply
```

Destroy Services
```bash
terraform destroy
```

#### Inspect State
When you apply your configuration, Terraform writes data into a file called `terraform.tfstate` which can have secret values

How to share state: https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate

Show state
```bash
terraform show
```

Show State List
```bash
terraform state list
```

Just use `terraform state` to see whats possible


##### Share state with team mates
It is possible with HCP Terraform: https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate

- Create an Terraform Account: https://app.terraform.io/session
- Join an Organization or create one
- Add the following code to root main.tf if you created a new organization
 ```code
terraform {

cloud {

organization = "Fabo011"

workspaces {

name = "terraform-test"

}

}
required_version = ">= 1.1.0"

}
  ```
- Execute `terraform init`


---

### Terraform Block

The `terraform {}` block contains Terraform settings, including the required providers Terraform will use to provision your infrastructure. For each provider, the `source` attribute defines an optional hostname, a namespace, and the provider type. Terraform installs providers from the [Terraform Registry](https://registry.terraform.io/) by default. In this example configuration, the `azurerm` provider's source is defined as `hashicorp/azurerm`, which is shorthand for `registry.terraform.io/hashicorp/azurerm`.

You can also define a version constraint for each provider in the `required_providers` block. The `version` attribute is optional, but we recommend using it to enforce the provider version. Without it, Terraform will always use the latest version of the provider, which may introduce breaking changes.

To learn more, reference the [provider source documentation](https://developer.hashicorp.com/terraform/language/providers/requirements).

### [](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build#providers)

### Providers

The `provider` block configures the specified provider, in this case `azurerm`. A provider is a plugin that Terraform uses to create and manage your resources. You can define multiple provider blocks in a Terraform configuration to manage resources from different providers.

### [](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build#resource)

### Resource

Use `resource` blocks to define components of your infrastructure. A resource might be a physical component such as a server, or it can be a logical resource such as a Heroku application.

Resource blocks have two strings before the block: the resource type and the resource name. In this example, the resource type is `azurerm_resource_group` and the name is `rg`. The prefix of the type maps to the name of the provider. In the example configuration, Terraform manages the `azurerm_resource_group` resource with the `azurerm` provider. Together, the resource type and resource name form a unique ID for the resource. For example, the ID for your network is `azurerm_resource_group.rg`.

Resource blocks contain arguments which you use to configure the resource. The [Azure provider documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) documents supported resources and their configuration options, including [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) and its supported arguments.