# Provider Configuration: AWS - Sets up the AWS provider with authentication credentials and region
provider "aws" {
 access_key = var.access_key # Specifies the AWS access key obtained from the var.access_key variable
 secret_key = var.secret_key # Specifies the AWS secret key obtained from the var.secret_key variable
 region = var.region # Specifies the AWS region obtained from the var.region variable

}
