
# Terraform VPC, Subnet, S3 Bucket, Security Group, and EC2 Instance Setup

## Project Overview

This project automates the setup of a basic AWS infrastructure using Terraform. It includes:

1. **VPC Creation**: A Virtual Private Cloud (VPC) with a defined CIDR block.
2. **Subnets**: Creation of multiple subnets within the VPC.
3. **S3 Bucket**: Setup of an S3 bucket to store Terraform state and for general use.
4. **Security Group**: Configuration of security group rules for EC2 instances.
5. **EC2 Instances**: Launching two web instances with custom user data scripts for initialization.

## Modules

### 1. VPC Module (`my_vpc`)
- **Source**: `./modules/vpc_module`
- **CIDR Block**: `10.0.0.0/16`

This module creates the VPC with the provided CIDR block.

### 2. Subnet Module (`my_subnets`)
- **Source**: `./modules/subnet_module`
- **VPC ID**: Retrieved from the `my_vpc` module.
- **Subnet CIDR Blocks**: 
  - `10.0.1.0/24`
  - `10.0.2.0/24`
  - `10.0.3.0/24`

This module sets up subnets within the VPC.

### 3. S3 Bucket Module (`s3_bucket`)
- **Source**: `./modules/s3_bucket`
- **Bucket Name**: Dynamically set using `var.s3name`.

This module creates an S3 bucket, and it is used to store the Terraform state remotely.

### 4. Security Group Module (`security_group`)
- **Source**: `./modules/security_group_module`
- **VPC ID**: Retrieved from the `my_vpc` module.
- **Ingress Ports**: Allows traffic on ports `80`, `8080`, `443`, and `22`.

This module defines the security group rules for managing access to EC2 instances.

### 5. EC2 Instances Module (`web_instances`)
- **Source**: `./modules/web_instances`
- **Subnets**: Retrieves subnet IDs from the `my_subnets` module.
- **AMI ID**: Defined using `var.ami_id`.
- **User Data Scripts**: Custom scripts are used for initializing the two web instances.

This module launches two EC2 web instances and configures them using user data scripts.

## Outputs

- **Subnet IDs**: The subnet IDs created by the `my_subnets` module.
- **Bucket Name**: The name of the S3 bucket created.
- **Bucket ARN**: The Amazon Resource Name (ARN) of the S3 bucket.
- **Security Group ID**: The ID of the created security group (if included as an output in the `security_group` module).

## Terraform Backend Configuration

To store Terraform state remotely on AWS S3:

```hcl
terraform {
  backend "s3" {
    bucket = "your_name_of_the_bucket"
    key    = "terraform/state.tfstate"
    region = "your_region"
  }
}
```

Ensure that the backend configuration is valid after running the Terraform code for the first time.

## Setup Instructions

1. **Install Terraform**: Ensure Terraform is installed on your system.
2. **Configure AWS Credentials**: Set up AWS credentials with necessary permissions to create resources.
3. **Define Variables**: Set up your variables like `var.s3name` for the S3 bucket name and `var.ami_id` for the EC2 instances.
4. **Run Terraform Commands**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

   After applying, Terraform will create the VPC, subnets, S3 bucket, security group, and EC2 instances.

## Notes

- Ensure that the CIDR blocks and ports match your security requirements.
- The S3 bucket name must be globally unique.
- Modify the user data scripts as necessary for your web instance requirements.

---

As part of my DevOps studies, this project demonstrates how to automate infrastructure setup using Terraform, including VPCs, subnets, EC2 instances, and S3 buckets.
