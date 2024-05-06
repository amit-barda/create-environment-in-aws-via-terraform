# Variable: subnet_ids - Specifies the list of subnet IDs where instances will be deployed
variable "subnet_ids" {
  type        = list(string)  
}

# Variable: ami_id - Specifies the ID of the  AMI used for instances
variable "ami_id" {
  type        = string  
}

# Variable: user_data_scripts - Specifies the list of user data scripts for initializing instances
variable "user_data_scripts" {
  type        = list(string)  
}

# Resource: aws_instance - Defines EC2 instances
resource "aws_instance" "web_instances" {
  count         = length(var.subnet_ids)  # Creates instances for each subnet ID in the subnet_ids list
  ami           = var.ami_id  # Specifies the AMI ID for the instances
  instance_type = "t2.micro"  # Defines the instance type as t2.micro
  subnet_id     = var.subnet_ids[count.index]  # Associates each instance with a subnet from the subnet_ids list
  user_data     = var.user_data_scripts[count.index]  # Provides user data script for initializing each instance

  tags = {
    Name = "Web Instance ${count.index + 1}"  # Tags each instance with a unique name
  }
}

# Output: web_instance_public_ips - Retrieves the public IP addresses of the created instances
output "web_instance_public_ips" {
  value = [aws_instance.web_instances.*.public_ip]  # Outputs a list of public IP addresses of all instances
}
