# -----------------------
# Input Variables
# -----------------------

variable "db_password" {
  description = "Password for the PostgreSQL RDS instance"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name of your existing S3 bucket"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the AWS EC2 Key Pair"
  type        = string
  default     = "grocerymate-key"
}

variable "public_key_path" {
  description = "Path to your EC2 public key file"
  type        = string
  default     = "C:\\Users\\HP\\.ssh\\grocerymate-key.pub"
}
