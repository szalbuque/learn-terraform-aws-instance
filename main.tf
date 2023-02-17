# call modules, locals and data-sources to create all the resources

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

# Create a VPC
resource "aws_vpc" "dio-exercise-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "dio_exercise_vpc"
  }
}

# Create public subnet
resource "aws_subnet" "dio-exercise-subnet"{
  vpc_id = aws_vpc.dio-exercise-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "dio_exercise_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "dio-exercise-gateway" {
  vpc_id = aws_vpc.dio-exercise-vpc.id

  tags = {
    Name = "dio_exercise_gateway"
  }
}

# Create route table
resource "aws_route_table" "dio-exercise-rt" {
  vpc_id = aws_vpc.dio-exercise-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dio-exercise-gateway.id
  }

  tags = {
    Name = "dio-exercise-rt"
  }
}

# Create default route
resource "aws_route" "dio-exercise-drt" {
  route_table_id            = aws_route_table.dio-exercise-rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.dio-exercise-gateway.id
}

# Link subnet to route table
resource "aws_route_table_association" "dio-exercise-pub-link" {
  subnet_id      = aws_subnet.dio-exercise-subnet.id
  route_table_id = aws_route_table.dio-exercise-rt.id
}

resource "aws_key_pair" "TF_key" {
  key_name = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "TF_key" {
  content = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

resource "aws_instance" "bastion" {
  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-054b8cfc266c5041d"]
  subnet_id              = aws_subnet.dio-exercise-subnet.id
  associate_public_ip_address = true
  key_name = "TF_key"

  tags = {
    Name = "bastion host"
  }
}

resource "aws_instance" "app" {
  count                  = 3
  ami                    = "ami-830c94e3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-054b8cfc266c5041d"]
  subnet_id              = aws_subnet.dio-exercise-subnet.id
  key_name = "TF_key"

  tags = {
    Name = "app${count.index}"
  }
}

