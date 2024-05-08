# Variable: region - Specifies the AWS region
variable "region" {
  default     = "us-east-1" 
}


# Variable: access_key - Specifies the AWS access key
variable "access_key" {
  type        = string
  default     = "your_key"
}

# Variable: secret_key - Specifies the AWS secret key
variable "secret_key" {
  type        = string
  default     = "your_key"
}

# Variable: s3name - Specifies the name of the S3 bucket
variable "s3name" {
  type        = string
  default     = "your_custom_name_for_bucket"
}
 
# Variable: ami_id - Specifies the ID of the AMI
variable "ami_id" {
  type        = string
  default     = "ami-080e1f13689e07408" # exemple for ami image 
}
