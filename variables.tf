# Task 1: AWS Account variables

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "gha_role" {
  description = "IAM role used by GitHub Actions"
  type        = string
  default     = "GithubActionsRole"
}

variable "iam_policies" {
  description = "List of Required IAM Policies"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess" # For future dynamodb setup of S3 backend
  ]
}

# Task 2: networking variables

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

# Task 2: EC2 variables

variable "ec2_amazon_linux_ami" {
  description = "EC2 Instance Image for Bastion Host and Testing"
  default     = "ami-0e6a13e7a5b66ff4d"
}

variable "ssh_pk" {
  description = "SSH Public Key to connect to Bastion Host"
  type        = string
}

variable "ssh_inbound_ip" {
  description = "Specify CIDR block to limit inbound ssh traffic to the NAT Instance/Bastion Host"
  default     = ["0.0.0.0/0"]
}

# Task 3: k3s Setup

variable "token" {
  description = "k3s Server token for k3s Agents"
  type        = string
}