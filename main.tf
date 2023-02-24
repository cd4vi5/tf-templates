provider "aws" {
    region = "eu-west-2"
    access_key = "AKIAVXAQNSOUGRTYR2DD"
    secret_key = "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"
}

resource "aws_instance" "tf-test-ec2-01" {
ami = "ami-09ee0944866c73f62"
instance_type = "t2.micro"

tags = {
    Purpose = "Test"
    Name = "tf-test-ec2-01"

}

}


