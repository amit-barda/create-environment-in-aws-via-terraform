
# Variable: bucket_name - Specifies the name of the S3 bucket
variable "bucket_name" {
}

# Resource: `aws_s3_bucket - Defines an S3 bucket resource
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name  # Specifies the bucket name using the value from the bucket_name variable
  acl    = "private"        # Sets the ACL to private for access
}
 
# Output: bucket_name - Retrieves the name of the created S3 bucket
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket  # Outputs the name of the S3 bucket created by the resource
}

# Output: bucket_arn - Retrieves the ARN of the created S3 bucket
output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn  # Outputs the ARN of the S3 bucket created by the resource
}
