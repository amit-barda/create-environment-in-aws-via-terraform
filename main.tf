# Module: my_vpc - Creates a VPC
module "my_vpc" {
  source          = "./modules/vpc_module"
  vpc_cidr_block = "10.0.0.0/16" # Defines the CIDR block for the VPC
}

# Module: my_subnets - Sets up subnets within the VPC
module "my_subnets" {
  source            = "./modules/subnet_module"
  vpc_id            = module.my_vpc.vpc_id # Retrieves VPC ID from the my_vpc module
  subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Defines subnet CIDR blocks
}


# Output: subnet_ids - Retrieves subnet IDs
output "subnet_ids" {
  value = module.my_subnets.subnet_ids
}

# Module: s3_bucket - Configures an S3 bucket
module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = var.s3name  # Specifies the bucket name from the var.s3name variable
}

# Output: bucket_name - Retrieves the bucket name
output "bucket_name" {
  value = module.s3_bucket.bucket_name # Outputs bucket name from the s3_bucket module
}

# Output: bucket_arn - Retrieves the bucket ARN
output "bucket_arn" {
  value = module.s3_bucket.bucket_arn # Outputs bucket ARN from the s3_bucket module
}

# Module: security_group - Defines security group rules
module "security_group" {
  source         = "./modules/security_group_module"
  vpc_id         = module.my_vpc.vpc_id # Retrieves VPC ID from the my_vpc module
  ingress_ports  = [80, 8080, 443, 22] # Specifies allowed ingress ports for the security group
}

# Module: web_instances - Launches EC2 instances
module "web_instances" {
  source             = "./modules/web_instances"
  subnet_ids         = [module.my_subnets.subnet_ids[0], module.my_subnets.subnet_ids[1]] # Retrieves subnet IDs from my_subnets module
  ami_id             = var.ami_id # Specifies the AMI ID from the var.ami_id variable
  user_data_scripts  = [ # Defines user data scripts for initializing instances
    <<-EOF
    #!/bin/bash
    echo "This is user data for Web Instance 1" > /var/www/html/index.html
    EOF
    ,
    <<-EOF
    #!/bin/bash
    echo "This is user data for Web Instance 2" > /var/www/html/index.html
    EOF
  ]
}


# Terraform Backend Configuration - Stores Terraform state remotely on aws
//
It will only work after the first run of the code

terraform {
  backend "s3" {
    bucket         = "your_name_of_the_bucket"
    key            = "terraform/state.tfstate"
    region         = "your_region"
  }
}
//
