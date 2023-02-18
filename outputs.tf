/*
Modules also have output values. You can reference them with the module.MODULE_NAME.OUTPUT_NAME naming
convention. In the Terraform Registry for the module, click on the Outputs tab to find all outputs for
the module.

You can reference module outputs in other parts of your configuration. 
Terraform will not display module outputs by default. 
You must create a corresponding output in your root module and set it to the module's output. 
*/

output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = module.vpc.public_subnets
}

output "ec2_instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = module.ec2_instances[*].public_ip
}