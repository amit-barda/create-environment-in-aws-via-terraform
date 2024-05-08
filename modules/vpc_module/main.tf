
# Variable: vpc_cidr_block - Specifies the CIDR block for the VPC
variable "vpc_cidr_block" {
}

# Resource: aws_vpc - Defines a VPC resource
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block  # Specifies the CIDR block for the VPC using the value from the vpc_cidr_block variable
}

# Output: vpc_id - Retrieves the ID of the created VPC
output "vpc_id" {
  value = aws_vpc.my_vpc.id  # Outputs the ID of the VPC created by the resource
}

