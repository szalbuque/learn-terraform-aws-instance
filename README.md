# Repository with files used to learn Terraform + AWS
## Terraform modules (https://developer.hashicorp.com/terraform/tutorials/modules/module)
* A Terraform module is a set of Terraform configuration files in a single directory. Even a simple configuration consisting of a single directory with one or more .tf files is a module. When you run Terraform commands directly from such a directory, it is considered the root module.
* A configuration can use module blocks to call modules in other directories. When Terraform encounters a module block, it loads and processes that module's configuration files.
* Modules can either be loaded from the local filesystem, or a remote source, like Terraform Registry, for example.
## Best practices:
* Start writing the configuration with modules in mind;
* Name your provider "terraform-PROVIDER-NAME", like "terraform-AWS-project1", for example;
* Use local modules to organize and encapsulate your code, even if you aren't using or publishing remote modules;
* Use the public Terraform Registry to find useful modules;
* Publish and share modules with your team.

https://developer.hashicorp.com/terraform/tutorials/modules/module-use

* Usei o exemplo e funcionou, após corrigir as permissões do terraform-user, no AWS IAM, para permitir ssm:getParameters
* Falta atribuir um par de chaves às instâncias EC2 para que seja possível acessá-las por SSH.
