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

* I used the files of the example in the website above and it worked after I gave the wright permissions for the "terraform-user", in the AWS IAM, so it can access "ssm:getParameters".
* To access the EC2 instances, I´ll need a key pair.

## Creating the key pair:
* The key pair is a resource that can be created independently of the other resources that will use it.
* One can use the AWS console to create a key pair as seen below:

![](images/create%20key%20pair%20console.png)

* But, as I am using terraform modules, I want to include a module for creating the key pair that will be used by the EC2 instances.
* Besides, I want to save the private key to my local computer, so that I can access the EC2 instances from it, using SSH.
1. Added the TLS provider to the terraform.tf file.
2. Added the variables: key_name, public_key, private_key_algorithm and private_key_rsa_bits to the variables.tf file.
3. Added the sections "key pair" and "private key" to the output.tf file.