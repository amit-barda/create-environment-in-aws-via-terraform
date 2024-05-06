# Variable: vpc_id - Specifies the ID of the VPC where subnets will be created
variable "vpc_id" {}

# Variable: subnet_cidr_blocks - Specifies the list of CIDR blocks for subnets
variable "subnet_cidr_blocks" {
  type        = list(string)  
}

# Resource: aws_subnet - Defines subnets within the specified VPC
resource "aws_subnet" "subnets" {
  count           = length(var.subnet_cidr_blocks)  # Creates subnets for each CIDR block specified
  vpc_id          = var.vpc_id  # Associates the subnets with the specified VPC ID
  cidr_block      = var.subnet_cidr_blocks[count.index]  # Specifies the CIDR block for each subnet
  map_public_ip_on_launch = true  # Enables automatic assignment of public IP addresses to instances launched in the subnet

  tags = {
    Name = "Subnet ${count.index + 1}"  # Tags each subnet with a unique name
  }
}

# Output: subnet_ids - Retrieves the IDs of the created subnets
output "subnet_ids" {
  value = aws_subnet.subnets[*].id  # Outputs a list of subnet IDs created by the resource
}
