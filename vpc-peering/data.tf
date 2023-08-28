data "aws_vpc" "vpc-a"{
    tags = {
      "Name" = "vpc-a"
    }
}

data "aws_vpc" "vpc-b"{
    tags = {
      "Name" = "vpc-b"
    }
}

data "aws_vpc" "vpc-c"{
    tags = {
      "Name" = "vpc-c"
    }
}