locals {
  region = "us-east-1"
  azs    = ["us-east-1a", "us-east-1b"]
}

module "vpc-a" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  map_public_ip_on_launch = true

  name = "vpc-a"

  cidr = "10.0.0.0/16"
  azs  = local.azs

  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true

}

module "vpc-b" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  map_public_ip_on_launch = true

  name = "vpc-b"

  cidr = "10.1.0.0/16"
  azs  = local.azs

  public_subnets = ["10.1.0.0/24", "10.1.1.0/24"]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true

}

module "vpc-c" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vpc-c"
  
  map_public_ip_on_launch = true

  cidr = "10.2.0.0/16"
  azs  = local.azs

  public_subnets = ["10.2.0.0/24", "10.2.1.0/24"]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true

}
