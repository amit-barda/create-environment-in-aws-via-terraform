# Variable: region - Specifies the AWS region
variable "region" {
  default     = "us-east-1" 
}


# Variable: access_key - Specifies the AWS access key
variable "access_key" {
  type        = string
  default     = "put here ur shit"
}

# Variable: secret_key - Specifies the AWS secret key
variable "secret_key" {
  type        = string
  default     = "some is here like abuv"
}

# Variable: s3name - Specifies the name of the S3 bucket
variable "s3name" {
  type        = string
  default     = "fromterraformforwebsiteprojcet2024"
}
 
# Variable: ami_id - Specifies the ID of the AMI
variable "ami_id" {
  type        = string
  default     = "ami-080e1f13689e07408"
}
