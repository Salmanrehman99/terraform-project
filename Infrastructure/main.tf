# -----------------------
# Terraform & AWS Provider
# -----------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# -----------------------
# AWS Provider (Dynamic Region & Profile)
# -----------------------
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
  default     = "default"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


# -----------------------
# Fetch Availability Zones dynamically
# -----------------------
data "aws_availability_zones" "available" {
  state = "available"
}

# -----------------------
# EC2 AMI
# -----------------------
ami = var.ec2_ami_id


# -----------------------
# VPC & Networking
# -----------------------
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = { Name = "igw" }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-rt" }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags   = { Name = "private-rt" }
}

# -----------------------
# Public Subnet
# -----------------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = { Name = "public-subnet" }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# -----------------------
# Private Subnets
# -----------------------
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = { Name = "private-subnet-1" }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = { Name = "private-subnet-2" }
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}


# -----------------------
# Security Groups
# -----------------------
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.main_vpc.id


  ingress {
    description = "SSH access from user-provided IPs only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidr
  }


  ingress {
    description = "Flask App Port"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "web-sg" }
}

resource "aws_security_group" "rds_sg" {
  name   = "rds-sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "rds-sg" }
}
# -----------------------
# EC2 Key Pair
# -----------------------
resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

# -----------------------
# IAM Role & Policy for EC2 to Access S3
# -----------------------
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "ec2_s3_policy" {
  name        = "ec2-s3-policy"
  description = "Full access to specific S3 bucket for EC2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:*"
      Resource = [
        "arn:aws:s3:::${var.bucket_name}",
        "arn:aws:s3:::${var.bucket_name}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach_policy" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.ec2_s3_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

# -----------------------
# EC2 Instance
# -----------------------
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = aws_key_pair.ec2_key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  
  monitoring = true

  tags = {
    Name = var.ec2_name
  }
}

# -----------------------
# RDS Subnet Group
# -----------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
 name = "rds-private-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

# -----------------------
# RDS PostgreSQL
# -----------------------
resource "aws_db_instance" "postgres" {
  identifier             = var.db_identifier
  allocated_storage      = var.rds_allocated_storage
  engine                 = var.rds_engine
  instance_class         = var.rds_instance_class
  storage_type           = var.rds_storage_type

  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  publicly_accessible    = false
  skip_final_snapshot    = true

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

# -----------------------
# SNS Topic for EC2 CPU Alerts
# -----------------------
resource "aws_sns_topic" "ec2_cpu_alerts" {
  name = "ec2-cpu-utilization-alerts"
}

# -----------------------
# SNS Email Subscription
# -----------------------
resource "aws_sns_topic_subscription" "ec2_cpu_email" {
  count     = length(var.email_address)
  topic_arn = aws_sns_topic.ec2_cpu_alerts.arn
  protocol  = "email"
  endpoint  = var.email_address[count.index]
}

# -----------------------
# CloudWatch Alarm for EC2 CPU Utilization
# -----------------------
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  alarm_name          = "ec2-cpu-high-${aws_instance.web_server.id}"
  alarm_description   = "Alarm when EC2 CPU exceeds 80%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80

  evaluation_periods = 2
  period             = 60
  statistic           = "Average"

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  alarm_actions = [aws_sns_topic.ec2_cpu_alerts.arn]

  treat_missing_data        = "notBreaching"
  insufficient_data_actions = []

  dimensions = {
    InstanceId = aws_instance.web_server.id
  }
}

