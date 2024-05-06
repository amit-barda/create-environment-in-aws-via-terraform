# Variable: vpc_id - Specifies the ID of the VPC where the security group will be created
variable "vpc_id" {}

# Variable: ingress_ports - Specifies the list of ingress ports to allow traffic
variable "ingress_ports" {
  type        = list(number)  
}

# Resource: aws_security_group - Defines a security group
resource "aws_security_group" "web_sg" {
  vpc_id = var.vpc_id  # Associates the security group with the specified VPC ID

  # Dynamic block to create ingress rules for each port in the ingress_ports list
  dynamic "ingress" {
    for_each = var.ingress_ports  # Iterates over each ingress port specified in the ingress_ports list
    content {
      from_port   = ingress.value  # Sets the from_port to the current ingress port
      to_port     = ingress.value  # Sets the to_port to the current ingress port
      protocol    = "tcp"          # Sets the protocol to TCP
      cidr_blocks = ["0.0.0.0/0"]  # Allows traffic from any IP address
    }
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port   = 0          # Sets the from_port to 0 (all ports)
    to_port     = 0          # Sets the to_port to 0 (all ports)
    protocol    = "-1"       # Sets the protocol to all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allows traffic to any IP address
  }
}

# Output: security_group_id - Retrieves the ID of the created security group
output "security_group_id" {
  value = aws_security_group.web_sg.id  # Outputs the ID of the security group created by the resource
}
