## Provider
provider "aws" {
  region     = "eu-west-2"
  access_key = "AKIAVXAQNSOUGRTYR2DD"
  secret_key = "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"
}

## VPC Resource
resource "aws_vpc" "tf-test-vpc-01" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "tf-test-vpc-01"
    Purpose = "Test"
    enable_dns_support = true
    enable_dns_hostnames = true
  }

}

## Subnet AZ 1
resource "aws_subnet" "tf-test-subnet-01" {
  vpc_id            = aws_vpc.tf-test-vpc-01.id
  cidr_block        = "10.0.99.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name    = "tf-test-subnet-01"
    Purpose = "Test"
  }
}

## Subnet AZ 2
resource "aws_subnet" "tf-test-subnet-02" {
  vpc_id            = aws_vpc.tf-test-vpc-01.id
  cidr_block        = "10.0.98.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name    = "tf-test-subnet-02"
    Purpose = "Test"
  }
}

## Ec2 001
resource "aws_spot_instance_request" "tf-spot-test-01" {
  ami           = "ami-0aaa5410833273cfe"
  spot_price    = "0.01"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-test-subnet-01.id
  security_groups = ["${aws_security_group.tf-ingress-ssh-test.id}"]

  tags = {
    Name    = "tf-spot-test-01"
    Purpose = "Test"
  }
}

## Ec2 002  
resource "aws_spot_instance_request" "tf-spot-test-02" {
  ami           = "ami-0aaa5410833273cfe"
  spot_price    = "0.01"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-test-subnet-02.id
  security_groups = ["${aws_security_group.tf-ingress-ssh-test.id}"]

  tags = {
    Name    = "tf-spot-test-02"
    Purpose = "Test"
  }
}

## Security Groups
resource "aws_security_group" "tf-ingress-ssh-test" {
  name   = "allow-ssh-sg"
  vpc_id = aws_vpc.tf-test-vpc-01.id

  ingress {
    cidr_blocks = [
      "92.233.64.164/32"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
