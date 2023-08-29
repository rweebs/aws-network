resource "aws_security_group" "allow_ssh_a" {
  name   = "allow_ssh_vpc_a"
  vpc_id = module.vpc-a.vpc_id

  #Incoming traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = 33434
    to_port     = 33436
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh_b" {
  name   = "allow_ssh_vpc_b"
  vpc_id = module.vpc-b.vpc_id

  #Incoming traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = 33434
    to_port     = 33436
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh_c" {
  name   = "allow_ssh_vpc_c"
  vpc_id = module.vpc-c.vpc_id

  #Incoming traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Incoming traffic
  ingress {
    from_port   = 33434
    to_port     = 33436
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"] #replace it with your ip address
  }

  #Outgoing traffic
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2-vpc-a" {
  ami               = local.ami
  instance_type     = "t3.micro"
  availability_zone = local.azs[0]
  key_name          = "tf-key-pair"
  subnet_id         = module.vpc-a.public_subnets[0]
  security_groups   = [aws_security_group.allow_ssh_a.id]
  tags = {
    Name = "EC2 VPC A - AZ1"
  }
}

resource "aws_instance" "ec2-vpc-b" {
  ami               = local.ami
  instance_type     = "t3.micro"
  availability_zone = local.azs[0]
  key_name          = "tf-key-pair"
  subnet_id         = module.vpc-b.public_subnets[0]
  security_groups   = [aws_security_group.allow_ssh_b.id]
  tags = {
    Name = "EC2 VPC B - AZ1"
  }
}

resource "aws_instance" "ec2-vpc-c" {
  ami               = local.ami
  instance_type     = "t3.micro"
  availability_zone = local.azs[0]
  key_name          = "tf-key-pair"
  subnet_id         = module.vpc-c.public_subnets[0]
  security_groups   = [aws_security_group.allow_ssh_c.id]
  tags = {
    Name = "EC2 VPC C - AZ1"
  }
}