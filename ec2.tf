

resource "aws_instance" "ec2-vpc-a" {
ami           = "ami-08a52ddb321b32a8c"
instance_type = "t3.micro"
availability_zone = "us-east-1a"
key_name = "tf-key-pair"
subnet_id = module.vpc-a.public_subnets[0]
tags = {
Name = "EC2 VPC A - AZ1"
}
}

resource "aws_instance" "ec2-vpc-b" {
ami           = "ami-08a52ddb321b32a8c"
instance_type = "t3.micro"
availability_zone = "us-east-1a"
key_name = "tf-key-pair"
subnet_id = module.vpc-b.public_subnets[0]
tags = {
Name = "EC2 VPC B - AZ1"
}
}

resource "aws_instance" "ec2-vpc-c" {
ami           = "ami-08a52ddb321b32a8c"
instance_type = "t3.micro"
availability_zone = "us-east-1a"
key_name = "tf-key-pair"
subnet_id = module.vpc-c.public_subnets[0]
tags = {
Name = "EC2 VPC C - AZ1"
}
}