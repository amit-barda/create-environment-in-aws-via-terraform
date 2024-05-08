# Provider Configuration: AWS - Sets up the AWS provider with authentication credentials and region
provider "aws" {
 access_key = var.access_key # Specifies the AWS access key 
 secret_key = var.secret_key # Specifies the AWS secret key 
 region = var.region # Specifies the AWS region 

}
