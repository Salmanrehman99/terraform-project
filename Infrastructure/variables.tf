# Input Variables
# -----------------------
variable "db_identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "Name of your S3 bucket"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the AWS EC2 Key Pair"
  type        = string
}

variable "email_address" {
  description = "Email addresses to receive CloudWatch alerts"
  type        = list(string)
}

variable "public_key_path" {
  description = "Path to your EC2 public key file"
  type        = string
}

variable "ssh_allowed_cidr" {
  description = "List of CIDR blocks allowed to SSH into EC2"
  type        = list(string)
}

variable "ec2_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "web-server"
}

# -----------------------
# VPC & Subnet Variables
# -----------------------
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
}

# -----------------------
# RDS Variables
# -----------------------
variable "rds_allocated_storage" {
  description = "Allocated storage for RDS instance (GB)"
  type        = number
}

variable "rds_engine" {
  description = "RDS database engine"
  type        = string
}

variable "rds_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "rds_storage_type" {
  description = "RDS storage type"
  type        = string
}

